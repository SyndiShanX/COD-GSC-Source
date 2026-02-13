/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2399.gsc
*************************************************/

_isalive() {
  if(istrue(self.inlaststand)) {
    return 0;
  }

  return isalive(self);
}