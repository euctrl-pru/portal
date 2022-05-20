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




<!-- By CSS the container element will fill 64% (0.8 the width) the height and 80% the width of the window. -->
<div id="container" style="position: relative; width: 80vw; height: 64vh;">
  <div id="map" style="position: absolute; width: 100%; height: 100%;"></div>
</div>

<script type="module">

import {Runtime, Inspector, Library} from "https://cdn.jsdelivr.net/npm/@observablehq/runtime@4/dist/runtime.js";
import notebook from "https://api.observablehq.com/@espinielli/central-route-charging-office-zones-and-rates.js?v=3";

// To avoid the chart itself affecting the size of its container, the chart is
// absolutely-positioned within the container element that determines the size.
const map = document.querySelector("#map");
const container = map.parentNode;

// Embed the chart cell from the notebook into the chart element.
const library = new Library();
const runtime = new Runtime(library);
const main = runtime.module(notebook, name => {
  if (name === "map") {
    return new Inspector(map);
  }
});

// Redefine width and height to be a generator created by the resizer function
// below to observe the size of the container.
main.redefine("width", resizer(container, "width"));
main.redefine("height", resizer(container, "height"));

// Rather making separate generators for width and height, here’s a generalized
// generator “factory” that watches the given dimension of the given element.
// (Note: depends on browser ResizeObserver support.)
function resizer(element, dimension) {
  return library.Generators.observe(notify => {
    let value = notify(element.getBoundingClientRect()[dimension]); // initial value
    const observer = new ResizeObserver(([entry]) => {
      const newValue = entry.contentRect[dimension];
      if (newValue !== value) {
        notify(value = newValue);
      }
    });
    observer.observe(element);
    return () => observer.disconnect();
  });
}

</script>


## See Also


* {{< a_blank_ectrl "CRCO" "https://www.eurocontrol.int/crco" >}}
* {{< a_blank_lexicon "Airspace User" "https://ext.eurocontrol.int/lexicon/index.php/Airspace_User" >}}
