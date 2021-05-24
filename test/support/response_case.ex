defmodule NotionElixir.ResponseCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias NotionElixir.Response
      import NotionElixir.ResponseCase
    end
  end

  def successful_list_response() do
    parsed =
      File.read!("./test/fixtures/list_response.json")
      |> Jason.decode!()

    {:ok,
     %Tesla.Env{
       __client__: %Tesla.Client{},
       __module__: Tesla,
       body: parsed,
       method: :get,
       opts: [],
       query: [],
       status: 200,
       url: "https://api.notion.com/v1/databases",
       headers: [
         {"connection", "keep-alive"},
         {"date", "Sun, 23 May 2021 15:55:50 GMT"},
         {"etag", "W/\"9a0-tAVthDnUg2YxRuNLwRntg1bGtPE\""},
         {"server", "cloudflare"},
         {"vary", "Accept-Encoding"},
         {"content-length", "2464"},
         {"content-type", "application/json; charset=utf-8"},
         {"x-dns-prefetch-control", "off"},
         {"x-frame-options", "SAMEORIGIN"},
         {"strict-transport-security", "max-age=5184000; includeSubDomains"},
         {"x-download-options", "noopen"},
         {"x-content-type-options", "nosniff"},
         {"x-xss-protection", "1; mode=block"},
         {"referrer-policy", "same-origin"},
         {"content-security-policy",
          "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://gist.github.com https://apis.google.com https://api.amplitude.com https://widget.intercom.io https://js.intercomcdn.com https://logs-01.loggly.com https://cdn.segment.com https://analytics.pgncs.notion.so https://o324374.ingest.sentry.io https://checkout.stripe.com https://js.stripe.com https://embed.typeform.com https://admin.typeform.com https://public.profitwell.com js.sentry-cdn.com https://platform.twitter.com https://cdn.syndication.twimg.com https://www.googletagmanager.com https://x.clearbitjs.com; connect-src 'self' https://msgstore.www.notion.so wss://msgstore.www.notion.so ws://localhost:* https://notion-emojis.s3-us-west-2.amazonaws.com https://s3-us-west-2.amazonaws.com https://s3.us-west-2.amazonaws.com https://notion-production-snapshots-2.s3.us-west-2.amazonaws.com https: http: https://api.amplitude.com https://api.embed.ly https://js.intercomcdn.com https://api-iam.intercom.io wss://nexus-websocket-a.intercom.io https://logs-01.loggly.com https://api.segment.io https://api.pgncs.notion.so https://o324374.ingest.sentry.io https://checkout.stripe.com https://js.stripe.com https://cdn.contentful.com https://preview.contentful.com https://images.ctfassets.net https://www2.profitwell.com https://api.unsplash.com https://boards-api.greenhouse.io; font-src 'self' data: https://cdnjs.cloudflare.com https://js.intercomcdn.com; img-src 'self' data: blob: https: https://platform.twitter.com https://syndication.twitter.com https://pbs.twimg.com https://ton.twimg.com www.googletagmanager.com; style-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com https://github.githubassets.com https://platform.twitter.com https://ton.twimg.com; frame-src https: http:; media-src https: http:"},
         {"x-content-security-policy",
          "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://gist.github.com https://apis.google.com https://api.amplitude.com https://widget.intercom.io https://js.intercomcdn.com https://logs-01.loggly.com https://cdn.segment.com https://analytics.pgncs.notion.so https://o324374.ingest.sentry.io https://checkout.stripe.com https://js.stripe.com https://embed.typeform.com https://admin.typeform.com https://public.profitwell.com js.sentry-cdn.com https://platform.twitter.com https://cdn.syndication.twimg.com https://www.googletagmanager.com https://x.clearbitjs.com; connect-src 'self' https://msgstore.www.notion.so wss://msgstore.www.notion.so ws://localhost:* https://notion-emojis.s3-us-west-2.amazonaws.com https://s3-us-west-2.amazonaws.com https://s3.us-west-2.amazonaws.com https://notion-production-snapshots-2.s3.us-west-2.amazonaws.com https: http: https://api.amplitude.com https://api.embed.ly https://js.intercomcdn.com https://api-iam.intercom.io wss://nexus-websocket-a.intercom.io https://logs-01.loggly.com https://api.segment.io https://api.pgncs.notion.so https://o324374.ingest.sentry.io https://checkout.stripe.com https://js.stripe.com https://cdn.contentful.com https://preview.contentful.com https://images.ctfassets.net https://www2.profitwell.com https://api.unsplash.com https://boards-api.greenhouse.io; font-src 'self' data: https://cdnjs.cloudflare.com https://js.intercomcdn.com; img-src 'self' data: blob: https: https://platform.twitter.com https://syndication.twitter.com https://pbs.twimg.com https://ton.twimg.com www.googletagmanager.com; style-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com https://github.githubassets.com https://platform.twitter.com https://ton.twimg.com; frame-src https: http:; media-src https: http:"},
         {"x-webkit-csp",
          "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://gist.github.com https://apis.google.com https://api.amplitude.com https://widget.intercom.io https://js.intercomcdn.com https://logs-01.loggly.com https://cdn.segment.com https://analytics.pgncs.notion.so https://o324374.ingest.sentry.io https://checkout.stripe.com https://js.stripe.com https://embed.typeform.com https://admin.typeform.com https://public.profitwell.com js.sentry-cdn.com https://platform.twitter.com https://cdn.syndication.twimg.com https://www.googletagmanager.com https://x.clearbitjs.com; connect-src 'self' https://msgstore.www.notion.so wss://msgstore.www.notion.so ws://localhost:* https://notion-emojis.s3-us-west-2.amazonaws.com https://s3-us-west-2.amazonaws.com https://s3.us-west-2.amazonaws.com https://notion-production-snapshots-2.s3.us-west-2.amazonaws.com https: http: https://api.amplitude.com https://api.embed.ly https://js.intercomcdn.com https://api-iam.intercom.io wss://nexus-websocket-a.intercom.io https://logs-01.loggly.com https://api.segment.io https://api.pgncs.notion.so https://o324374.ingest.sentry.io https://checkout.stripe.com https://js.stripe.com https://cdn.contentful.com https://preview.contentful.com https://images.ctfassets.net https://www2.profitwell.com https://api.unsplash.com https://boards-api.greenhouse.io; font-src 'self' data: https://cdnjs.cloudflare.com https://js.intercomcdn.com; img-src 'self' data: blob: https: https://platform.twitter.com https://syndication.twitter.com https://pbs.twimg.com https://ton.twimg.com www.googletagmanager.com; style-src 'self' 'unsafe-inline' https://cdnjs.cloudflare.com https://github.githubassets.com https://platform.twitter.com https://ton.twimg.com; frame-src https: http:; media-src https: http:"},
         {"set-cookie",
          "notion_browser_id=54e6a6d6-c6ab-442e-83a5-eedcbb27600c; Domain=www.notion.so; Path=/; Expires=Wed, 29 Jan 2053 17:42:30 GMT; Secure"},
         {"cf-cache-status", "DYNAMIC"},
         {"cf-request-id", "0a3b89a99800000cd3f93b7000000001"},
         {"expect-ct",
          "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""},
         {"cf-ray", "653f7888f82f0cd3-LAX"}
       ]
     }}
  end
end
