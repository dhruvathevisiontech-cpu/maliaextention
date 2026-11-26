
const { setGlobalOptions } = require("firebase-functions");
const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { defineSecret } = require("firebase-functions/params");

setGlobalOptions({ maxInstances: 10 });

// Shopify Admin API token stored securely in Firebase Secret Manager.
const shopifyAdminToken = defineSecret("SHOPIFY_ADMIN_ACCESS_TOKEN");

// IMPORTANT: Replace this with your actual Shopify .myshopify.com domain.
const SHOPIFY_STORE_DOMAIN = "YOUR-STORE.myshopify.com";

const SHOPIFY_API_VERSION = "2026-10";

exports.checkShopifyCustomerByEmail = onCall(
  {
    secrets: [shopifyAdminToken],
    timeoutSeconds: 30,
  },
  async (request) => {
    const email = String(request.data?.email || "")
      .trim()
      .toLowerCase();

    if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
      throw new HttpsError(
        "invalid-argument",
        "Please provide a valid email address."
      );
    }

    const query = `
      query CheckCustomer($searchQuery: String!) {
        customers(first: 1, query: $searchQuery) {
          nodes {
            id
            email
          }
        }
      }
    `;

    try {
      const response = await fetch(
        `https://${SHOPIFY_STORE_DOMAIN}/admin/api/${SHOPIFY_API_VERSION}/graphql.json`,
        {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-Shopify-Access-Token": shopifyAdminToken.value(),
          },
          body: JSON.stringify({
            query,
            variables: {
              searchQuery: `email:${email}`,
            },
          }),
        }
      );

      const result = await response.json();

      if (!response.ok || result.errors) {
        console.error("Shopify API error:", result);
        throw new Error("Shopify customer lookup failed.");
      }

      const customers = result.data?.customers?.nodes || [];

      const exists = customers.some(
        (customer) =>
          customer.email?.toLowerCase() === email
      );

      return {
        exists: exists,
      };
    } catch (error) {
      console.error("Customer lookup failed:", error);

      throw new HttpsError(
        "internal",
        "Unable to check customer details right now."
      );
    }
  }
);
