#!/bin/bash


# 1. Install Hookdeck CLI if not already installed
if ! command -v hookdeck &> /dev/null
then
    echo "Hookdeck CLI not found. Installing..."
    curl -sf https://cli.hookdeck.com/install.sh | sh
else
    echo "Hookdeck CLI is already installed."
fi

# 2. Start Hookdeck CLI to listen for incoming webhooks
hookdeck listen &

# 3. Create a Shopify webhook using the Shopify API with a specific JSON payload
# Replace <SHOPIFY_STORE_URL>, <SHOPIFY_ACCESS_TOKEN>, and <WEBHOOK_URL> with your actual values
SHOPIFY_STORE_URL="<SHOPIFY_STORE_URL>"
SHOPIFY_ACCESS_TOKEN="<SHOPIFY_ACCESS_TOKEN>"
WEBHOOK_URL="<WEBHOOK_URL>"

curl -X POST "https://${SHOPIFY_STORE_URL}/admin/api/2022-01/webhooks.json" \
     -H "Content-Type: application/json" \
     -H "X-Shopify-Access-Token: ${SHOPIFY_ACCESS_TOKEN}" \
     -d '{
          "webhook": {
            "topic": "orders/create",
            "address": "'${WEBHOOK_URL}'",
            "format": "json"
          }
        }'

# 4. Verify that the received webhook is authentic and comes from Shopify
# This is handled by Hookdeck CLI

# 5. Display the results of the received webhooks for inspection
# This is handled by Hookdeck CLI