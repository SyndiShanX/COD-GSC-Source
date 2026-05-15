/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_inventory.gsc
*****************************************************/

main() {
  level.inventory = [];
}

inventory_create(var_0, var_1) {
  if(1) {
    return spawnStruct();
  }

  if(!isDefined(var_1)) {
    var_1 = 0;
  }

  var_2 = newhudelem();
  var_2.alignx = "right";
  var_2.aligny = "top";
  var_2.horzalign = "right";
  var_2.vertalign = "top";
  var_2.alpha = 0;
  var_2.index = level.inventory.size;
  var_2.show_icon = var_1;
  var_2 setshader(var_0, 40, 40);
  level.inventory[var_2.index] = var_2;
  inventroy_update();
  return var_2;
}

inventory_hide() {
  if(1) {
    return;
  }
  self.show_icon = 0;
  inventroy_update();
}

inventory_show() {
  if(1) {
    return;
  }
  self.show_icon = 1;
  inventroy_update();
}

inventroy_update() {
  if(1) {
    return;
  }
  var_0 = -18;
  var_1 = 8;
  var_2 = 42;
  var_3 = 0;

  for(var_4 = 0; var_4 < level.inventory.size; var_4++) {
    if(level.inventory[var_4].show_icon) {
      var_5 = var_1 + var_2 * var_3;

      if(var_5 != level.inventory[var_4].y) {
        level.inventory[var_4].x = var_0;

        if(level.inventory[var_4].alpha != 0) {
          level.inventory[var_4] moveovertime(0.3);
        }

        level.inventory[var_4].y = var_5;
      }

      if(level.inventory[var_4].alpha != 1) {
        level.inventory[var_4] fadeovertime(0.3);
        level.inventory[var_4].alpha = 1;
      }

      var_3++;
      continue;
    }

    level.inventory[var_4] fadeovertime(0.3);
    level.inventory[var_4].alpha = 0;
  }
}

inventory_destroy() {
  if(1) {
    return;
  }
  self destroy();
  var_0 = 0;
  var_1 = level.inventory;
  level.inventory = [];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(isDefined(var_1[var_2])) {
      level.inventory[level.inventory.size] = var_1[var_2];
    }
  }

  inventroy_update();
}