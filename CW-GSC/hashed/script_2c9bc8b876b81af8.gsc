/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_2c9bc8b876b81af8.gsc
***********************************************/

#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\cp_common\spawn_manager;

#namespace spawn_manager;

function spawn_manager_debug() {
  for(;;) {
    if(!getdvarint(#"ai_debugspawnmanager", 0)) {
      wait 0.1;
      continue;
    }

    managers = get_spawn_manager_array();
    manageractivecount = 0;
    managerpotentialspawncount = 0;
    level.debugactivemanagers = [];

    for(i = 0; i < managers.size; i++) {
      if(isDefined(managers[i]) && isDefined(managers[i].enable)) {
        if(managers[i].enable || !managers[i].enable && isDefined(managers[i].spawners)) {
          if(managers[i].count < 0 || managers[i].count > managers[i].spawncount) {
            if(managers[i].enable && isDefined(managers[i].sm_active_count)) {
              manageractivecount += 1;
              managerpotentialspawncount += managers[i].sm_active_count;
            }

            level.debugactivemanagers[level.debugactivemanagers.size] = managers[i];
          }
        }
      }
    }

    spawn_manager_debug_hud_update(level.spawn_manager_active_ai, level.spawn_manager_total_count, level.spawn_manager_max_ai, manageractivecount, managerpotentialspawncount);
    waitframe(1);
  }
}

function spawn_manager_debug_hud_update(active_ai, spawn_ai, max_ai, active_managers, potential_ai) {
  if(getdvarint(#"ai_debugspawnmanager", 0)) {
    if(!isDefined(level.spawn_manager_debug_hud_title)) {
      level.spawn_manager_debug_hud_title = newdebughudelem();
      level.spawn_manager_debug_hud_title.alignx = "<dev string:x38>";
      level.spawn_manager_debug_hud_title.x = 120;
      level.spawn_manager_debug_hud_title.y = 40;
      level.spawn_manager_debug_hud_title.fontscale = 1.5;
      level.spawn_manager_debug_hud_title.color = (1, 1, 1);
    }

    if(!isDefined(level.spawn_manager_debug_hud)) {
      level.spawn_manager_debug_hud = [];
    }

    level.spawn_manager_debug_hud_title settext("<dev string:x40>" + spawn_ai + "<dev string:x5d>" + active_ai + "<dev string:x6e>" + potential_ai + "<dev string:x73>" + max_ai + "<dev string:x81>" + active_managers);

    for(i = 0; i < level.debugactivemanagers.size; i++) {
      if(!isDefined(level.spawn_manager_debug_hud[i])) {
        level.spawn_manager_debug_hud[i] = newdebughudelem();
        level.spawn_manager_debug_hud[i].alignx = "<dev string:x38>";
        level.spawn_manager_debug_hud[i].x = 125;
        level.spawn_manager_debug_hud[i].fontscale = 1;
        level.spawn_manager_debug_hud[i].y = level.spawn_manager_debug_hud_title.y + (i + 1) * 15;
      }

      if(isDefined(level.current_debug_spawn_manager) && level.debugactivemanagers[i] == level.current_debug_spawn_manager) {
        if(!level.debugactivemanagers[i].enable) {
          level.spawn_manager_debug_hud[i].color = (0, 0.4, 0);
        } else {
          level.spawn_manager_debug_hud[i].color = (0, 1, 0);
        }
      } else if(level.debugactivemanagers[i].enable) {
        level.spawn_manager_debug_hud[i].color = (1, 1, 1);
      } else {
        level.spawn_manager_debug_hud[i].color = (0.4, 0.4, 0.4);
      }

      text = "<dev string:x98>" + level.debugactivemanagers[i].sm_id + "<dev string:x9d>";
      text += "<dev string:xa2>" + level.debugactivemanagers[i].spawncount;
      text += "<dev string:xba>" + level.debugactivemanagers[i].activeai.size + "<dev string:xce>" + level.debugactivemanagers[i].sm_active_count_min + "<dev string:xd4>" + level.debugactivemanagers[i].sm_active_count_max + "<dev string:xd9>";
      text += "<dev string:xde>" + level.debugactivemanagers[i].allspawners.size;

      if(isDefined(level.debugactivemanagers[i].sm_group_size)) {
        text += "<dev string:xee>" + level.debugactivemanagers[i].sm_group_size + "<dev string:x100>" + level.debugactivemanagers[i].sm_group_size_min + "<dev string:xd4>" + level.debugactivemanagers[i].sm_group_size_max + "<dev string:xd9>";
      }

      level.spawn_manager_debug_hud[i] settext(text);
    }

    if(level.debugactivemanagers.size < level.spawn_manager_debug_hud.size) {
      for(i = level.debugactivemanagers.size; i < level.spawn_manager_debug_hud.size; i++) {
        if(isDefined(level.spawn_manager_debug_hud[i])) {
          level.spawn_manager_debug_hud[i] destroy();
        }
      }
    }
  }

  if(!getdvarint(#"ai_debugspawnmanager", 0)) {
    if(isDefined(level.spawn_manager_debug_hud_title)) {
      level.spawn_manager_debug_hud_title destroy();
    }

    if(isDefined(level.spawn_manager_debug_hud)) {
      for(i = 0; i < level.spawn_manager_debug_hud.size; i++) {
        if(isDefined(level.spawn_manager_debug_hud) && isDefined(level.spawn_manager_debug_hud[i])) {
          level.spawn_manager_debug_hud[i] destroy();
        }
      }

      level.spawn_manager_debug_hud = undefined;
    }
  }
}

function on_player_connect() {
  level thread spawn_manager_debug_spawn_manager();
}

function spawn_manager_debug_spawn_manager() {
  level notify(#"spawn_manager_debug_spawn_manager");
  level endon(#"spawn_manager_debug_spawn_manager");
  level.current_debug_spawn_manager = undefined;
  level.current_debug_spawn_manager_targetname = undefined;
  level.test_player = getPlayers()[0];
  current_spawn_manager_index = -1;
  old_spawn_manager_index = undefined;

  while(true) {
    if(!getDvar(#"ai_debugspawnmanager", 0)) {
      destroy_tweak_hud_elements();
      waitframe(1);
      continue;
    }

    if(isDefined(level.debugactivemanagers) && level.debugactivemanagers.size > 0) {
      if(current_spawn_manager_index == -1) {
        current_spawn_manager_index = 0;
        old_spawn_manager_index = 0;
      }

      if(level.test_player buttonPressed("<dev string:x105>")) {
        old_spawn_manager_index = current_spawn_manager_index;

        if(level.test_player buttonPressed("<dev string:x116>")) {
          current_spawn_manager_index--;

          if(current_spawn_manager_index < 0) {
            current_spawn_manager_index = 0;
          }
        }

        if(level.test_player buttonPressed("<dev string:x121>")) {
          current_spawn_manager_index++;

          if(current_spawn_manager_index > level.debugactivemanagers.size - 1) {
            current_spawn_manager_index = level.debugactivemanagers.size - 1;
          }
        }
      }

      if(isDefined(current_spawn_manager_index) && current_spawn_manager_index != -1) {
        if(isDefined(level.current_debug_spawn_manager) && isDefined(level.debugactivemanagers[current_spawn_manager_index])) {
          if(isDefined(old_spawn_manager_index) && old_spawn_manager_index == current_spawn_manager_index) {
            if(level.debugactivemanagers[current_spawn_manager_index].targetname != level.current_debug_spawn_manager_targetname) {
              for(i = 0; i < level.debugactivemanagers.size; i++) {
                if(level.debugactivemanagers[i].targetname == level.current_debug_spawn_manager_targetname) {
                  current_spawn_manager_index = i;
                  old_spawn_manager_index = i;
                }
              }
            }
          }
        }

        if(isDefined(level.debugactivemanagers[current_spawn_manager_index])) {
          level.current_debug_spawn_manager = level.debugactivemanagers[current_spawn_manager_index];
          level.current_debug_spawn_manager_targetname = level.debugactivemanagers[current_spawn_manager_index].targetname;
        }
      }

      if(isDefined(level.current_debug_spawn_manager)) {
        level.current_debug_spawn_manager spawn_manager_debug_spawn_manager_values_dpad();
      }
    } else {
      destroy_tweak_hud_elements();
    }

    wait 0.25;
  }
}

function spawn_manager_debug_spawner_values() {
  while(true) {
    if(!getdvarint(#"ai_debugspawnmanager", 0)) {
      wait 0.1;
      continue;
    }

    if(isDefined(level.current_debug_spawn_manager)) {
      spawn_manager = level.current_debug_spawn_manager;

      if(isDefined(spawn_manager.spawners)) {
        for(i = 0; i < spawn_manager.spawners.size; i++) {
          current_spawner = spawn_manager.spawners[i];

          if(isDefined(current_spawner) && current_spawner.count > 0) {
            spawnerfree = current_spawner.sm_active_count - current_spawner.activeai.size;
            print3d(current_spawner.origin + (0, 0, 65), "<dev string:x12e>" + current_spawner.count, (0, 1, 0), 1, 1.25, 2);
            print3d(current_spawner.origin + (0, 0, 85), "<dev string:x138>" + current_spawner.activeai.size + "<dev string:x6e>" + spawnerfree + "<dev string:x6e>" + current_spawner.sm_active_count, (0, 1, 0), 1, 1.25, 2);
          }
        }
      }

      waitframe(1);
    }

    waitframe(1);
  }
}

function ent_print(text) {
  self endon(#"death");

  while(true) {
    print3d(self.origin + (0, 0, 65), text, (0.48, 9.4, 0.76), 1, 1);
    waitframe(1);
  }
}

function spawn_manager_debug_spawn_manager_values_dpad() {
  if(!isDefined(level.current_debug_index)) {
    level.current_debug_index = 0;
  }

  if(!isDefined(level.spawn_manager_debug_hud2)) {
    level.spawn_manager_debug_hud2 = newdebughudelem();
    level.spawn_manager_debug_hud2.alignx = "<dev string:x38>";
    level.spawn_manager_debug_hud2.x = 10;
    level.spawn_manager_debug_hud2.y = 150;
    level.spawn_manager_debug_hud2.fontscale = 1.25;
    level.spawn_manager_debug_hud2.color = (1, 0, 0);
  }

  if(!isDefined(level.sm_active_count_title)) {
    level.sm_active_count_title = newdebughudelem();
    level.sm_active_count_title.alignx = "<dev string:x38>";
    level.sm_active_count_title.x = 10;
    level.sm_active_count_title.y = 165;
    level.sm_active_count_title.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_active_count_min_hud)) {
    level.sm_active_count_min_hud = newdebughudelem();
    level.sm_active_count_min_hud.alignx = "<dev string:x38>";
    level.sm_active_count_min_hud.x = 10;
    level.sm_active_count_min_hud.y = 180;
    level.sm_active_count_min_hud.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_active_count_max_hud)) {
    level.sm_active_count_max_hud = newdebughudelem();
    level.sm_active_count_max_hud.alignx = "<dev string:x38>";
    level.sm_active_count_max_hud.x = 10;
    level.sm_active_count_max_hud.y = 195;
    level.sm_active_count_max_hud.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_group_size_min_hud)) {
    level.sm_group_size_min_hud = newdebughudelem();
    level.sm_group_size_min_hud.alignx = "<dev string:x38>";
    level.sm_group_size_min_hud.x = 10;
    level.sm_group_size_min_hud.y = 210;
    level.sm_group_size_min_hud.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_group_size_max_hud)) {
    level.sm_group_size_max_hud = newdebughudelem();
    level.sm_group_size_max_hud.alignx = "<dev string:x38>";
    level.sm_group_size_max_hud.x = 10;
    level.sm_group_size_max_hud.y = 225;
    level.sm_group_size_max_hud.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_spawner_count_title)) {
    level.sm_spawner_count_title = newdebughudelem();
    level.sm_spawner_count_title.alignx = "<dev string:x38>";
    level.sm_spawner_count_title.x = 10;
    level.sm_spawner_count_title.y = 240;
    level.sm_spawner_count_title.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_spawner_count_min_hud)) {
    level.sm_spawner_count_min_hud = newdebughudelem();
    level.sm_spawner_count_min_hud.alignx = "<dev string:x38>";
    level.sm_spawner_count_min_hud.x = 10;
    level.sm_spawner_count_min_hud.y = 255;
    level.sm_spawner_count_min_hud.color = (1, 1, 1);
  }

  if(!isDefined(level.sm_spawner_count_max_hud)) {
    level.sm_spawner_count_max_hud = newdebughudelem();
    level.sm_spawner_count_max_hud.alignx = "<dev string:x38>";
    level.sm_spawner_count_max_hud.x = 10;
    level.sm_spawner_count_max_hud.y = 270;
    level.sm_spawner_count_max_hud.color = (1, 1, 1);
  }

  if(level.test_player buttonPressed("<dev string:x14c>")) {
    if(level.test_player buttonPressed("<dev string:x121>")) {
      level.current_debug_index++;

      if(level.current_debug_index > 7) {
        level.current_debug_index = 7;
      }
    }

    if(level.test_player buttonPressed("<dev string:x116>")) {
      level.current_debug_index--;

      if(level.current_debug_index < 0) {
        level.current_debug_index = 0;
      }
    }
  }

  set_debug_hud_colors();
  increase_value = 0;
  decrease_value = 0;

  if(level.test_player buttonPressed("<dev string:x14c>")) {
    if(level.test_player buttonPressed("<dev string:x15c>")) {
      decrease_value = 1;
    }

    if(level.test_player buttonPressed("<dev string:x169>")) {
      increase_value = 1;
    }
  }

  should_run_set_up = 0;

  if(increase_value || decrease_value) {
    if(increase_value) {
      add = 1;
    } else {
      add = -1;
    }

    switch (level.current_debug_index) {
      case 0:
        if(self.sm_active_count + add > self.sm_active_count_max) {
          self.sm_active_count_max = self.sm_active_count + add;
        }

        if(self.sm_active_count + add < self.sm_active_count_min) {
          if(self.sm_active_count + add > 0) {
            self.sm_active_count_min = self.sm_active_count + add;
          }
        }

        should_run_set_up = 1;
        self.sm_active_count += add;
        break;
      case 1:
        if(self.sm_active_count_min + add < self.sm_group_size_max) {
          modify_debug_hud2("<dev string:x177>");
          break;
        }

        if(self.sm_active_count_min + add > self.sm_active_count_max) {
          modify_debug_hud2("<dev string:x1de>");
          break;
        }

        should_run_set_up = 1;
        self.sm_active_count_min += add;
        break;
      case 2:
        if(self.sm_active_count_max + add < self.sm_active_count_min) {
          modify_debug_hud2("<dev string:x249>");
          break;
        }

        should_run_set_up = 1;
        self.sm_active_count_max += add;
        break;
      case 3:
        if(self.sm_group_size_min + add > self.sm_group_size_max) {
          modify_debug_hud2("<dev string:x2b4>");
          break;
        }

        should_run_set_up = 1;
        self.sm_group_size_min += add;
        break;
      case 4:
        if(self.sm_group_size_max + add < self.sm_group_size_min) {
          modify_debug_hud2("<dev string:x319>");
          break;
        }

        if(self.sm_group_size_max + add > self.sm_active_count) {
          modify_debug_hud2("<dev string:x37e>");
          break;
        }

        should_run_set_up = 1;
        self.sm_group_size_max += add;
        break;
      case 5:
        if(self.sm_spawner_count + add > self.allspawners.size) {
          modify_debug_hud2("<dev string:x3df>");
          break;
        }

        if(self.sm_spawner_count + add <= 0) {
          modify_debug_hud2("<dev string:x455>");
          break;
        }

        if(self.sm_spawner_count + add < self.sm_spawner_count_min) {
          if(self.sm_spawner_count + add > 0) {
            self.sm_spawner_count_min = self.sm_spawner_count + add;
          }
        }

        if(self.sm_spawner_count + add > self.sm_spawner_count_max) {
          self.sm_spawner_count_max = self.sm_spawner_count + add;
        }

        should_run_set_up = 1;
        self.sm_spawner_count += add;
        break;
      case 6:
        if(self.sm_spawner_count_min + add > self.sm_spawner_count_max) {
          modify_debug_hud2("<dev string:x47e>");
          break;
        }

        should_run_set_up = 1;
        self.sm_spawner_count_min += add;
        break;
      case 7:
        if(self.sm_spawner_count_max + add < self.sm_spawner_count_min) {
          modify_debug_hud2("<dev string:x4ec>");
          break;
        }

        should_run_set_up = 1;
        self.sm_spawner_count_max += add;
        break;
    }
  }

  if(should_run_set_up) {
    level.current_debug_spawn_manager spawn_manager_debug_setup();
  }

  if(isDefined(self)) {
    level.sm_active_count_min_hud settext("<dev string:x55a>" + self.sm_active_count_min);
    level.sm_active_count_max_hud settext("<dev string:x573>" + self.sm_active_count_max);
    level.sm_group_size_min_hud settext("<dev string:x58c>" + self.sm_group_size_min);
    level.sm_group_size_max_hud settext("<dev string:x5a4>" + self.sm_group_size_max);

    if(isDefined(self.sm_spawner_count)) {
      level.sm_spawner_count_title settext("<dev string:x5bc>" + self.sm_spawner_count);
      level.sm_spawner_count_min_hud settext("<dev string:x5d2>" + self.sm_spawner_count_min);
      level.sm_spawner_count_max_hud settext("<dev string:x5ec>" + self.sm_spawner_count_max);
    }
  }
}

function set_debug_hud_colors() {
  switch (level.current_debug_index) {
    case 0:
      level.sm_active_count_title.color = (0, 1, 0);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 1:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (0, 1, 0);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 2:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (0, 1, 0);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 3:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (0, 1, 0);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 4:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (0, 1, 0);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 5:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (0, 1, 0);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 6:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (0, 1, 0);
      level.sm_spawner_count_max_hud.color = (1, 1, 1);
      break;
    case 7:
      level.sm_active_count_title.color = (1, 1, 1);
      level.sm_active_count_min_hud.color = (1, 1, 1);
      level.sm_active_count_max_hud.color = (1, 1, 1);
      level.sm_group_size_min_hud.color = (1, 1, 1);
      level.sm_group_size_max_hud.color = (1, 1, 1);
      level.sm_spawner_count_title.color = (1, 1, 1);
      level.sm_spawner_count_min_hud.color = (1, 1, 1);
      level.sm_spawner_count_max_hud.color = (0, 1, 0);
      break;
  }
}

function spawn_manager_debug_setup() {
  if(isDefined(level.current_debug_index) && level.current_debug_index != 5) {
    self.sm_spawner_count = randomintrange(self.sm_spawner_count_min, self.sm_spawner_count_max + 1);
  }

  if(isDefined(level.current_debug_index) && level.current_debug_index != 0) {
    self.sm_active_count = randomintrange(self.sm_active_count_min, self.sm_active_count_max + 1);
  }

  self.spawners = self spawn_manager_get_spawners();
  assert(self.count >= self.count_min);
  assert(self.count <= self.count_max);
  assert(self.sm_active_count >= self.sm_active_count_min);
  assert(self.sm_active_count <= self.sm_active_count_max);
  assert(self.sm_group_size_max <= self.sm_active_count);
  assert(self.sm_group_size_min <= self.sm_active_count);
}

function modify_debug_hud2(text) {
  self notify(#"modified");
  waitframe(1);
  level.spawn_manager_debug_hud2 settext(text);
  level.spawn_manager_debug_hud2 thread moniter_debug_hud2();
}

function moniter_debug_hud2() {
  self endon(#"modified");
  wait 10;
  level.spawn_manager_debug_hud2 settext("<dev string:x606>");
}

function destroy_tweak_hud_elements() {
  if(isDefined(level.sm_active_count_title)) {
    level.sm_active_count_title destroy();
  }

  if(isDefined(level.sm_active_count_min_hud)) {
    level.sm_active_count_min_hud destroy();
  }

  if(isDefined(level.sm_active_count_max_hud)) {
    level.sm_active_count_max_hud destroy();
  }

  if(isDefined(level.sm_group_size_min_hud)) {
    level.sm_group_size_min_hud destroy();
  }

  if(isDefined(level.sm_group_size_max_hud)) {
    level.sm_group_size_max_hud destroy();
  }

  if(isDefined(level.sm_spawner_count_title)) {
    level.sm_spawner_count_title destroy();
  }

  if(isDefined(level.sm_spawner_count_min_hud)) {
    level.sm_spawner_count_min_hud destroy();
  }

  if(isDefined(level.sm_spawner_count_max_hud)) {
    level.sm_spawner_count_max_hud destroy();
  }
}