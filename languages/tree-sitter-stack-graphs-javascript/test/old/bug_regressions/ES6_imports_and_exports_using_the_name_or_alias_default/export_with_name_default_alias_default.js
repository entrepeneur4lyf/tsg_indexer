/*--- path: a.js ---*/

export default 1;

/*--- path: b.js ---*/

export { default as default } from "./a.js";

/*--- path: c.js ---*/

import bar from "./b.js";

/**/ bar;
//   ^ defined: 3, 7, 11
