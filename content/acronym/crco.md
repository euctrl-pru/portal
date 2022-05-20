---
title: CRCO - Central Route Charges Office
slug: crco
---

Airspace users which fly in the controlled airspace of EUROCONTROL’s Member States
pay for the air traffic services they use.

EUROCONTROL's Central Route Charges Office (CRCO) charges airspace users
for these services on behalf of the Member States.

The CRCO calculates the route charges due to the Member States for the
services provided, bills the airspace users and distributes the route
charges to the States concerned.


<!-- Setting an initial height may help initial page layout, but would be overridden on resize. -->
<iframe id="embed" width="1063" frameborder="0" src="https://observablehq.com/embed/@espinielli/central-route-charging-office-zones-and-rates?cells=map"></iframe>

<script type="module">

// Select the embed iframe.
const iframe = document.querySelector("#embed");

// The Embedly protocol is to send the height as part of a stringified object.
// In this example, the resize message is the only message being sent; however,
// the checks are good practice, lest we try to interpret unrelated messages as
// resize events. https://docs.embed.ly/v1.0/docs/provider-height-resizing
function onMessage(message) {
  if (message.source !== iframe.contentWindow) return;
  let {data} = message;

  // If message isn’t valid JSON, it must not be our resize event.
  if (typeof data === "string") {
    try {
      data = JSON.parse(data);
    } catch (ignore) {
      return;
    }
  }

  // Make sure it’s the resize event.
  if (data.context !== "iframe.resize") return;

  // Set the iframe’s height!
  iframe.style.height = `${data.height}px`;
}

// Attach our listener for the message from the iframe
addEventListener("message", onMessage);

</script>


## See Also


* {{< a_blank_ectrl "CRCO" "https://www.eurocontrol.int/crco" >}}
* {{< a_blank_lexicon "Airspace User" "https://ext.eurocontrol.int/lexicon/index.php/Airspace_User" >}}
