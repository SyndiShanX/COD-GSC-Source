/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2c9bc8b876b81af8.gsc
***********************************************/

#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\spawn_manager;
#namespace spawn_manager;

function function_50a58f3() {
  for(;;) {
    if(!getdvarint(#"ai_debugspawnmanager", 0)) {
      wait 0.1;
      continue;
    }

    managers = function_aaa872c1();
    var_6788a4c8 = 0;
    var_f1535cf1 = 0;
    level.var_2db12862 = [];

    for(i = 0; i < managers.size; i++) {
      if(isDefined(managers[i]) && isDefined(managers[i].enable)) {
        if(managers[i].enable || !managers[i].enable && isDefined(managers[i].spawners)) {
          if(managers[i].count < 0 || managers[i].count > managers[i].spawncount) {
            if(managers[i].enable && isDefined(managers[i].var_7600cd86)) {
              var_6788a4c8 += 1;
              var_f1535cf1 += managers[i].var_7600cd86;
            }

            level.var_2db12862[level.var_2db12862.size] = managers[i];
          }
        }
      }
    }

    function_58bee038(level.var_e4fdd7dd, level.var_7c90ec19, level.var_539b11be, var_6788a4c8, var_f1535cf1);
    waitframe(1);
  }
}

function function_58bee038(active_ai, spawn_ai, max_ai, var_93847faa, var_b9ce72a0) {
  if(getdvarint(#"ai_debugspawnmanager", 0)) {
    if(!isDefined(level.var_9d76aef3)) {
      level.var_9d76aef3 = newdebughudelem();
      level.var_9d76aef3.alignx = "<dev string:x38>";
      level.var_9d76aef3.x = 120;
      level.var_9d76aef3.y = 40;
      level.var_9d76aef3.fontscale = 1.5;
      level.var_9d76aef3.color = (1, 1, 1);
    }

    if(!isDefined(level.var_472721ed)) {
      level.var_472721ed = [];
    }

    level.var_9d76aef3 settext("<dev string:x40>" + spawn_ai + "<dev string:x5d>" + active_ai + "<dev string:x6e>" + var_b9ce72a0 + "<dev string:x73>" + max_ai + "<dev string:x81>" + var_93847faa);

    for(i = 0; i < level.var_2db12862.size; i++) {
      if(!isDefined(level.var_472721ed[i])) {
        level.var_472721ed[i] = newdebughudelem();
        level.var_472721ed[i].alignx = "<dev string:x38>";
        level.var_472721ed[i].x = 125;
        level.var_472721ed[i].fontscale = 1;
        level.var_472721ed[i].y = level.var_9d76aef3.y + (i + 1) * 15;
      }

      if(isDefined(level.var_362ad52e) && level.var_2db12862[i] == level.var_362ad52e) {
        if(!level.var_2db12862[i].enable) {
          level.var_472721ed[i].color = (0, 0.4, 0);
        } else {
          level.var_472721ed[i].color = (0, 1, 0);
        }
      } else if(level.var_2db12862[i].enable) {
        level.var_472721ed[i].color = (1, 1, 1);
      } else {
        level.var_472721ed[i].color = (0.4, 0.4, 0.4);
      }

      text = "<dev string:x98>" + level.var_2db12862[i].sm_id + "<dev string:x9d>";
      text += "<dev string:xa2>" + level.var_2db12862[i].spawncount;
      text += "<dev string:xba>" + level.var_2db12862[i].var_5ee53e3.size + "<dev string:xce>" + level.var_2db12862[i].var_2023678c + "<dev string:xd4>" + level.var_2db12862[i].var_b02a42f7 + "<dev string:xd9>";
      text += "<dev string:xde>" + level.var_2db12862[i].allspawners.size;

      if(isDefined(level.var_2db12862[i].var_ed3f1bbb)) {
        text += "<dev string:xee>" + level.var_2db12862[i].var_ed3f1bbb + "<dev string:x100>" + level.var_2db12862[i].var_3ea8113 + "<dev string:xd4>" + level.var_2db12862[i].var_ff71eda6 + "<dev string:xd9>";
      }

      level.var_472721ed[i] settext(text);
    }

    if(level.var_2db12862.size < level.var_472721ed.size) {
      for(i = level.var_2db12862.size; i < level.var_472721ed.size; i++) {
        if(isDefined(level.var_472721ed[i])) {
          level.var_472721ed[i] destroy();
        }
      }
    }
  }

  if(!getdvarint(#"ai_debugspawnmanager", 0)) {
    if(isDefined(level.var_9d76aef3)) {
      level.var_9d76aef3 destroy();
    }

    if(isDefined(level.var_472721ed)) {
      for(i = 0; i < level.var_472721ed.size; i++) {
        if(isDefined(level.var_472721ed) && isDefined(level.var_472721ed[i])) {
          level.var_472721ed[i] destroy();
        }
      }

      level.var_472721ed = undefined;
    }
  }
}

function on_player_connect() {
  level thread function_15c21657();
}

function function_15c21657() {
  level notify(#"hash_5e7f7bd30640b0f8");
  level endon(#"hash_5e7f7bd30640b0f8");
  level.var_362ad52e = undefined;
  level.var_8a164bbe = undefined;
  level.test_player = getplayers()[0];
  var_d5ae2adf = -1;
  var_e8343926 = undefined;

  while(true) {
    if(!getDvar(#"ai_debugspawnmanager", 0)) {
      function_565627f7();
      waitframe(1);
      continue;
    }

    if(isDefined(level.var_2db12862) && level.var_2db12862.size > 0) {
      if(var_d5ae2adf == -1) {
        var_d5ae2adf = 0;
        var_e8343926 = 0;
      }

      if(level.test_player buttonPressed("<dev string:x105>")) {
        var_e8343926 = var_d5ae2adf;

        if(level.test_player buttonPressed("<dev string:x116>")) {
          var_d5ae2adf--;

          if(var_d5ae2adf < 0) {
            var_d5ae2adf = 0;
          }
        }

        if(level.test_player buttonPressed("<dev string:x121>")) {
          var_d5ae2adf++;

          if(var_d5ae2adf > level.var_2db12862.size - 1) {
            var_d5ae2adf = level.var_2db12862.size - 1;
          }
        }
      }

      if(isDefined(var_d5ae2adf) && var_d5ae2adf != -1) {
        if(isDefined(level.var_362ad52e) && isDefined(level.var_2db12862[var_d5ae2adf])) {
          if(isDefined(var_e8343926) && var_e8343926 == var_d5ae2adf) {
            if(level.var_2db12862[var_d5ae2adf].targetname != level.var_8a164bbe) {
              for(i = 0; i < level.var_2db12862.size; i++) {
                if(level.var_2db12862[i].targetname == level.var_8a164bbe) {
                  var_d5ae2adf = i;
                  var_e8343926 = i;
                }
              }
            }
          }
        }

        if(isDefined(level.var_2db12862[var_d5ae2adf])) {
          level.var_362ad52e = level.var_2db12862[var_d5ae2adf];
          level.var_8a164bbe = level.var_2db12862[var_d5ae2adf].targetname;
        }
      }

      if(isDefined(level.var_362ad52e)) {
        level.var_362ad52e function_77f8229b();
      }
    } else {
      function_565627f7();
    }

    wait 0.25;
  }
}

function function_258a6c7() {
  while(true) {
    if(!getdvarint(#"ai_debugspawnmanager", 0)) {
      wait 0.1;
      continue;
    }

    if(isDefined(level.var_362ad52e)) {
      spawn_manager = level.var_362ad52e;

      if(isDefined(spawn_manager.spawners)) {
        for(i = 0; i < spawn_manager.spawners.size; i++) {
          current_spawner = spawn_manager.spawners[i];

          if(isDefined(current_spawner) && current_spawner.count > 0) {
            var_20c0d5a8 = current_spawner.var_7600cd86 - current_spawner.var_5ee53e3.size;
            print3d(current_spawner.origin + (0, 0, 65), "<dev string:x12e>" + current_spawner.count, (0, 1, 0), 1, 1.25, 2);
            print3d(current_spawner.origin + (0, 0, 85), "<dev string:x138>" + current_spawner.var_5ee53e3.size + "<dev string:x6e>" + var_20c0d5a8 + "<dev string:x6e>" + current_spawner.var_7600cd86, (0, 1, 0), 1, 1.25, 2);
          }
        }
      }

      waitframe(1);
    }

    waitframe(1);
  }
}

function function_faf13f8e(text) {
  self endon(#"death");

  while(true) {
    print3d(self.origin + (0, 0, 65), text, (0.48, 9.4, 0.76), 1, 1);
    waitframe(1);
  }
}

function function_77f8229b() {
  if(!isDefined(level.var_809f2ccb)) {
    level.var_809f2ccb = 0;
  }

  if(!isDefined(level.var_311b1407)) {
    level.var_311b1407 = newdebughudelem();
    level.var_311b1407.alignx = "<dev string:x38>";
    level.var_311b1407.x = 10;
    level.var_311b1407.y = 150;
    level.var_311b1407.fontscale = 1.25;
    level.var_311b1407.color = (1, 0, 0);
  }

  if(!isDefined(level.var_efdd94a4)) {
    level.var_efdd94a4 = newdebughudelem();
    level.var_efdd94a4.alignx = "<dev string:x38>";
    level.var_efdd94a4.x = 10;
    level.var_efdd94a4.y = 165;
    level.var_efdd94a4.color = (1, 1, 1);
  }

  if(!isDefined(level.var_3ad36502)) {
    level.var_3ad36502 = newdebughudelem();
    level.var_3ad36502.alignx = "<dev string:x38>";
    level.var_3ad36502.x = 10;
    level.var_3ad36502.y = 180;
    level.var_3ad36502.color = (1, 1, 1);
  }

  if(!isDefined(level.var_af390e0d)) {
    level.var_af390e0d = newdebughudelem();
    level.var_af390e0d.alignx = "<dev string:x38>";
    level.var_af390e0d.x = 10;
    level.var_af390e0d.y = 195;
    level.var_af390e0d.color = (1, 1, 1);
  }

  if(!isDefined(level.var_d8499d3d)) {
    level.var_d8499d3d = newdebughudelem();
    level.var_d8499d3d.alignx = "<dev string:x38>";
    level.var_d8499d3d.x = 10;
    level.var_d8499d3d.y = 210;
    level.var_d8499d3d.color = (1, 1, 1);
  }

  if(!isDefined(level.var_ae00cf1d)) {
    level.var_ae00cf1d = newdebughudelem();
    level.var_ae00cf1d.alignx = "<dev string:x38>";
    level.var_ae00cf1d.x = 10;
    level.var_ae00cf1d.y = 225;
    level.var_ae00cf1d.color = (1, 1, 1);
  }

  if(!isDefined(level.var_92f8da9a)) {
    level.var_92f8da9a = newdebughudelem();
    level.var_92f8da9a.alignx = "<dev string:x38>";
    level.var_92f8da9a.x = 10;
    level.var_92f8da9a.y = 240;
    level.var_92f8da9a.color = (1, 1, 1);
  }

  if(!isDefined(level.var_254556d9)) {
    level.var_254556d9 = newdebughudelem();
    level.var_254556d9.alignx = "<dev string:x38>";
    level.var_254556d9.x = 10;
    level.var_254556d9.y = 255;
    level.var_254556d9.color = (1, 1, 1);
  }

  if(!isDefined(level.var_6c6a96f9)) {
    level.var_6c6a96f9 = newdebughudelem();
    level.var_6c6a96f9.alignx = "<dev string:x38>";
    level.var_6c6a96f9.x = 10;
    level.var_6c6a96f9.y = 270;
    level.var_6c6a96f9.color = (1, 1, 1);
  }

  if(level.test_player buttonPressed("<dev string:x14c>")) {
    if(level.test_player buttonPressed("<dev string:x121>")) {
      level.var_809f2ccb++;

      if(level.var_809f2ccb > 7) {
        level.var_809f2ccb = 7;
      }
    }

    if(level.test_player buttonPressed("<dev string:x116>")) {
      level.var_809f2ccb--;

      if(level.var_809f2ccb < 0) {
        level.var_809f2ccb = 0;
      }
    }
  }

  function_cfed27e3();
  var_3f9688af = 0;
  var_a1951b12 = 0;

  if(level.test_player buttonPressed("<dev string:x14c>")) {
    if(level.test_player buttonPressed("<dev string:x15c>")) {
      var_a1951b12 = 1;
    }

    if(level.test_player buttonPressed("<dev string:x169>")) {
      var_3f9688af = 1;
    }
  }

  var_178e08a4 = 0;

  if(var_3f9688af || var_a1951b12) {
    if(var_3f9688af) {
      add = 1;
    } else {
      add = -1;
    }

    switch (level.var_809f2ccb) {
      case 0:
        if(self.var_7600cd86 + add > self.var_b02a42f7) {
          self.var_b02a42f7 = self.var_7600cd86 + add;
        }

        if(self.var_7600cd86 + add < self.var_2023678c) {
          if(self.var_7600cd86 + add > 0) {
            self.var_2023678c = self.var_7600cd86 + add;
          }
        }

        var_178e08a4 = 1;
        self.var_7600cd86 += add;
        break;
      case 1:
        if(self.var_2023678c + add < self.var_ff71eda6) {
          function_7b732419("<dev string:x177>");
          break;
        }

        if(self.var_2023678c + add > self.var_b02a42f7) {
          function_7b732419("<dev string:x1de>");
          break;
        }

        var_178e08a4 = 1;
        self.var_2023678c += add;
        break;
      case 2:
        if(self.var_b02a42f7 + add < self.var_2023678c) {
          function_7b732419("<dev string:x249>");
          break;
        }

        var_178e08a4 = 1;
        self.var_b02a42f7 += add;
        break;
      case 3:
        if(self.var_3ea8113 + add > self.var_ff71eda6) {
          function_7b732419("<dev string:x2b4>");
          break;
        }

        var_178e08a4 = 1;
        self.var_3ea8113 += add;
        break;
      case 4:
        if(self.var_ff71eda6 + add < self.var_3ea8113) {
          function_7b732419("<dev string:x319>");
          break;
        }

        if(self.var_ff71eda6 + add > self.var_7600cd86) {
          function_7b732419("<dev string:x37e>");
          break;
        }

        var_178e08a4 = 1;
        self.var_ff71eda6 += add;
        break;
      case 5:
        if(self.var_82a78b41 + add > self.allspawners.size) {
          function_7b732419("<dev string:x3df>");
          break;
        }

        if(self.var_82a78b41 + add <= 0) {
          function_7b732419("<dev string:x455>");
          break;
        }

        if(self.var_82a78b41 + add < self.var_ae34b6c9) {
          if(self.var_82a78b41 + add > 0) {
            self.var_ae34b6c9 = self.var_82a78b41 + add;
          }
        }

        if(self.var_82a78b41 + add > self.var_25a70a68) {
          self.var_25a70a68 = self.var_82a78b41 + add;
        }

        var_178e08a4 = 1;
        self.var_82a78b41 += add;
        break;
      case 6:
        if(self.var_ae34b6c9 + add > self.var_25a70a68) {
          function_7b732419("<dev string:x47e>");
          break;
        }

        var_178e08a4 = 1;
        self.var_ae34b6c9 += add;
        break;
      case 7:
        if(self.var_25a70a68 + add < self.var_ae34b6c9) {
          function_7b732419("<dev string:x4ec>");
          break;
        }

        var_178e08a4 = 1;
        self.var_25a70a68 += add;
        break;
    }
  }

  if(var_178e08a4) {
    level.var_362ad52e function_2973e587();
  }

  if(isDefined(self)) {
    level.var_3ad36502 settext("<dev string:x55a>" + self.var_2023678c);
    level.var_af390e0d settext("<dev string:x573>" + self.var_b02a42f7);
    level.var_d8499d3d settext("<dev string:x58c>" + self.var_3ea8113);
    level.var_ae00cf1d settext("<dev string:x5a4>" + self.var_ff71eda6);

    if(isDefined(self.var_82a78b41)) {
      level.var_92f8da9a settext("<dev string:x5bc>" + self.var_82a78b41);
      level.var_254556d9 settext("<dev string:x5d2>" + self.var_ae34b6c9);
      level.var_6c6a96f9 settext("<dev string:x5ec>" + self.var_25a70a68);
    }
  }
}

function function_cfed27e3() {
  switch (level.var_809f2ccb) {
    case 0:
      level.var_efdd94a4.color = (0, 1, 0);
      level.var_3ad36502.color = (1, 1, 1);
      level.var_af390e0d.color = (1, 1, 1);
      level.var_d8499d3d.color = (1, 1, 1);
      level.var_ae00cf1d.color = (1, 1, 1);
      level.var_92f8da9a.color = (1, 1, 1);
      level.var_254556d9.color = (1, 1, 1);
      level.var_6c6a96f9.color = (1, 1, 1);
      break;
    case 1:
      level.var_efdd94a4.color = (1, 1, 1);
      level.var_3ad36502.color = (0, 1, 0);
      level.var_af390e0d.color = (1, 1, 1);
      level.var_d8499d3d.color = (1, 1, 1);
      level.var_ae00cf1d.color = (1, 1, 1);
      level.var_92f8da9a.color = (1, 1, 1);
      level.var_254556d9.color = (1, 1, 1);
      level.var_6c6a96f9.color = (1, 1, 1);
      break;
    case 2:
      level.var_efdd94a4.color = (1, 1, 1);
      level.var_3ad36502.color = (1, 1, 1);
      level.var_af390e0d.color = (0, 1, 0);
      level.var_d8499d3d.color = (1, 1, 1);
      level.var_ae00cf1d.color = (1, 1, 1);
      level.var_92f8da9a.color = (1, 1, 1);
      level.var_254556d9.color = (1, 1, 1);
      level.var_6c6a96f9.color = (1, 1, 1);
      break;
    case 3:
      level.var_efdd94a4.color = (1, 1, 1);
      level.var_3ad36502.color = (1, 1, 1);
      level.var_af390e0d.color = (1, 1, 1);
      level.var_d8499d3d.color = (0, 1, 0);
      level.var_ae00cf1d.color = (1, 1, 1);
      level.var_92f8da9a.color = (1, 1, 1);
      level.var_254556d9.color = (1, 1, 1);
      level.var_6c6a96f9.color = (1, 1, 1);
      break;
    case 4:
      level.var_efdd94a4.color = (1, 1, 1);
      level.var_3ad36502.color = (1, 1, 1);
      level.var_af390e0d.color = (1, 1, 1);
      level.var_d8499d3d.color = (1, 1, 1);
      level.var_ae00cf1d.color = (0, 1, 0);
      level.var_92f8da9a.color = (1, 1, 1);
      level.var_254556d9.color = (1, 1, 1);
      level.var_6c6a96f9.color = (1, 1, 1);
      break;
    case 5:
      level.var_efdd94a4.color = (1, 1, 1);
      level.var_3ad36502.color = (1, 1, 1);
      level.var_af390e0d.color = (1, 1, 1);
      level.var_d8499d3d.color = (1, 1, 1);
      level.var_ae00cf1d.color = (1, 1, 1);
      level.var_92f8da9a.color = (0, 1, 0);
      level.var_254556d9.color = (1, 1, 1);
      level.var_6c6a96f9.color = (1, 1, 1);
      break;
    case 6:
      level.var_efdd94a4.color = (1, 1, 1);
      level.var_3ad36502.color = (1, 1, 1);
      level.var_af390e0d.color = (1, 1, 1);
      level.var_d8499d3d.color = (1, 1, 1);
      level.var_ae00cf1d.color = (1, 1, 1);
      level.var_92f8da9a.color = (1, 1, 1);
      level.var_254556d9.color = (0, 1, 0);
      level.var_6c6a96f9.color = (1, 1, 1);
      break;
    case 7:
      level.var_efdd94a4.color = (1, 1, 1);
      level.var_3ad36502.color = (1, 1, 1);
      level.var_af390e0d.color = (1, 1, 1);
      level.var_d8499d3d.color = (1, 1, 1);
      level.var_ae00cf1d.color = (1, 1, 1);
      level.var_92f8da9a.color = (1, 1, 1);
      level.var_254556d9.color = (1, 1, 1);
      level.var_6c6a96f9.color = (0, 1, 0);
      break;
  }
}

function function_2973e587() {
  if(isDefined(level.var_809f2ccb) && level.var_809f2ccb != 5) {
    self.var_82a78b41 = randomintrange(self.var_ae34b6c9, self.var_25a70a68 + 1);
  }

  if(isDefined(level.var_809f2ccb) && level.var_809f2ccb != 0) {
    self.var_7600cd86 = randomintrange(self.var_2023678c, self.var_b02a42f7 + 1);
  }

  self.spawners = self function_bf4a387a();
  assert(self.count >= self.count_min);
  assert(self.count <= self.count_max);
  assert(self.var_7600cd86 >= self.var_2023678c);
  assert(self.var_7600cd86 <= self.var_b02a42f7);
  assert(self.var_ff71eda6 <= self.var_7600cd86);
  assert(self.var_3ea8113 <= self.var_7600cd86);
}

function function_7b732419(text) {
  self notify(#"modified");
  waitframe(1);
  level.var_311b1407 settext(text);
  level.var_311b1407 thread function_57ab061();
}

function function_57ab061() {
  self endon(#"modified");
  wait 10;
  level.var_311b1407 settext("<dev string:x606>");
}

function function_565627f7() {
  if(isDefined(level.var_efdd94a4)) {
    level.var_efdd94a4 destroy();
  }

  if(isDefined(level.var_3ad36502)) {
    level.var_3ad36502 destroy();
  }

  if(isDefined(level.var_af390e0d)) {
    level.var_af390e0d destroy();
  }

  if(isDefined(level.var_d8499d3d)) {
    level.var_d8499d3d destroy();
  }

  if(isDefined(level.var_ae00cf1d)) {
    level.var_ae00cf1d destroy();
  }

  if(isDefined(level.var_92f8da9a)) {
    level.var_92f8da9a destroy();
  }

  if(isDefined(level.var_254556d9)) {
    level.var_254556d9 destroy();
  }

  if(isDefined(level.var_6c6a96f9)) {
    level.var_6c6a96f9 destroy();
  }
}