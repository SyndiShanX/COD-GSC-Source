/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_reactions.gsc
*********************************************/

main() {
  if(isDefined(level.shark_functions)) {
    if(issubstr(self.model, "shark")) {
      self[[level.shark_functions["reactions"]]]();
      return;
    }
  }
}