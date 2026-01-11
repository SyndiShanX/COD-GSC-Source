/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\teargas_window1.gsc
****************************************************/

main() {
  if(self.type == "dog") {
    animscripts\traverse\shared::dog_wall_and_window_hop("wallhop", 40);
  }
  else {
    teargas_traverse_window();
  }
}

#using_animtree("generic_human");

teargas_traverse_window() {
  var_0 = randomintrange(1, 6);

  switch (var_0) {
    case 1:
      var_1 = [];
      var_1["traverseAnim"] = % teargas_window_1;
      var_1["traverseHeight"] = 36.0;
      animscripts\traverse\shared::dotraverse(var_1);
      break;
    case 2:
      var_1 = [];
      var_1["traverseAnim"] = % teargas_window_2;
      var_1["traverseHeight"] = 36.0;
      animscripts\traverse\shared::dotraverse(var_1);
      break;
    case 3:
      var_1 = [];
      var_1["traverseAnim"] = % teargas_window_3;
      var_1["traverseHeight"] = 36.0;
      animscripts\traverse\shared::dotraverse(var_1);
      break;
    case 4:
      var_1 = [];
      var_1["traverseAnim"] = % teargas_window_4;
      var_1["traverseHeight"] = 36.0;
      animscripts\traverse\shared::dotraverse(var_1);
      break;
    case 5:
      var_1 = [];
      var_1["traverseAnim"] = % teargas_window_5;
      var_1["traverseHeight"] = 36.0;
      animscripts\traverse\shared::dotraverse(var_1);
      break;
    case 6:
      var_1 = [];
      var_1["traverseAnim"] = % teargas_window_6;
      var_1["traverseHeight"] = 36.0;
      animscripts\traverse\shared::dotraverse(var_1);
      break;
  }
}