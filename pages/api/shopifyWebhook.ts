import { NextApiRequest, NextApiResponse } from 'next'
import crypto from 'crypto'

export default async function handler(req: NextApiRequest, res: NextApiResponse) {
  const { headers, body } = req;

  // Your Shopify app's secret key
  const SHOPIFY_APP_SECRET = process.env.SHOPIFY_APP_SECRET;

  // Check if SHOPIFY_APP_SECRET is defined
  if (!SHOPIFY_APP_SECRET) {
    res.status(500).json({ message: 'Server error' });
    return;
  }

  // Extract the HMAC from the headers
  const hmac = headers['x-shopify-hmac-sha256'];

  // Create a hash using the body and your app's secret key
  const hash = crypto
    .createHmac('sha256', SHOPIFY_APP_SECRET)
    .update(JSON.stringify(body))
    .digest('base64');

  // Compare the HMAC in the header with the hash we created
  if (hmac === hash) {
    // If they match, handle the webhook event (e.g., update your database)
    // TODO: Add your webhook handling code here

    res.status(200).json({ message: 'Success' });
  } else {
    res.status(401).json({ message: 'Unauthorized' });
  }
}