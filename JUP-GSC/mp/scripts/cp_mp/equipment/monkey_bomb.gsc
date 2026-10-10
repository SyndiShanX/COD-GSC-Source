/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\equipment\monkey_bomb.gsc
******************************************************/

#using script_9880b9dc28bc25e;
#using scripts\common\utility;
#using scripts\cp_mp\equipment;
#using scripts\engine\utility;
#namespace monkey_bomb;

function function_9cb7762eeb57f57c() {
  level.var_c36f48de0ba87814 = [];
  level.var_e0b07114267e08bb = [];
  level.var_fc48fdf7b8edde6c = &function_7119b9ec768ee712;
  level._effect["monkey_bomb_oob"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_monkey_bomb_despawn.vfx");
  level thread function_37ae9ad9c5dea6c2();
}

function function_f72973904792660f(grenade) {
  ref = scripts\cp_mp\equipment::function_7f245729fcb6414d(grenade.weapon_name);
  grenade.tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo(ref);

  if(!isDefined(grenade.tableinfo.bundle)) {
    assertmsg("<dev string:x1c>");
  }

  grenade endon("death");
  grenade hide();
  grenade.angles = self.angles;
  monkey_model = spawn("script_model", grenade.origin);
  monkey_model.angles = grenade.angles;
  monkey_model setModel("wm_jup_2h_zmb_monkey_bomb");
  monkey_model.grenade = grenade;
  monkey_model.team = self.team;
  monkey_model.attractor = add_attractor(monkey_model, 2, 2000, 0, undefined, &function_bbb16715e494b23, 0, undefined, 1);
  grenade.monkey_model = monkey_model;
  grenade.monkey_model linkTo(grenade);
  grenade.monkey_model.var_875170bdae054a5e = self;
  grenade.monkey_model utility::function_3677f2be30fdd581("sound", "throw");
  level.var_c36f48de0ba87814 = array_add(level.var_c36f48de0ba87814, grenade.monkey_model);
  grenade thread function_9b3a45e77a17ad86(monkey_model, monkey_model.attractor);
  level thread function_625a3cda727914a8(grenade);
  grenade waittill("missile_stuck", stuckto);
  grenade.monkey_model utility::function_3677f2be30fdd581("sound", "land");

  if(!isDefined(grenade) && isDefined(monkey_model)) {
    monkey_model delete();
  }

  if(isDefined(grenade) && isDefined(grenade.monkey_model)) {
    grenade.monkey_model.var_154288d91ba8cf1a = getclosestpointonnavmesh(grenade.monkey_model.origin, self);
    level.var_e0b07114267e08bb = array_add(level.var_e0b07114267e08bb, grenade.monkey_model);
  }
}

function function_625a3cda727914a8(grenade) {
  grenade endon("missile_stuck");
  msg = grenade waittill_any_timeout_1(10, "death");

  if(isDefined(msg) && msg == "death") {
    if(isDefined(grenade.monkey_model)) {
      array_remove(level.var_c36f48de0ba87814, grenade.monkey_model);

      if(isDefined(grenade.monkey_model.attractor)) {
        remove_attractor(grenade.monkey_model.attractor);
      }

      grenade.monkey_model delete();
    }
  }
}

function function_bbb16715e494b23(attractor, zombie) {
  if(istrue(zombie.var_8a29c4280a76bb7d)) {
    return 0;
  }

  if(is_equal(zombie.aicategory, "normal")) {
    if(zombie.team != attractor.source.team) {
      return 1;
    } else {
      return 0;
    }

    return;
  }

  return 0;
}

function function_9b3a45e77a17ad86(monkey_model, attractor) {
  self endon("missile_stuck");
  msg = waittill_any_timeout_1(13, "missile_water_impact");

  if(isDefined(msg) && msg == "missile_water_impact") {
    wait 1;
  }

  if(isDefined(attractor)) {
    remove_attractor(attractor);
  }

  if(!isDefined(self)) {
    if(isDefined(monkey_model)) {
      monkey_model delete();
    }

    return;
  }

  grenade_stolen_by_sam(self, undefined);
}

function private function_1d982537b9dcb924(player) {
  if(!isPlayer(player)) {
    return false;
  }

  if(issharedfuncdefined("game", "isCommonItemEnabled")) {
    if(!function_f3bb4f4911a1beb2("game", "isCommonItemEnabled")) {
      return false;
    }

    if(!(issharedfuncdefined("game", "obtainItemEquip") && issharedfuncdefined("game", "getItemBundleNameFromRef"))) {
      return false;
    }

    return true;
  }

  return false;
}

function grenade_stolen_by_sam(grenade, e_actor) {
  if(!isDefined(grenade.monkey_model)) {
    return;
  }

  monkey_model = grenade.monkey_model;
  direction = grenade.monkey_model.origin;
  direction = (direction[1], direction[0], 0);

  if(direction[1] < 0 || direction[0] > 0 && direction[1] > 0) {
    direction = (direction[0], direction[1] * -1, 0);
  } else if(direction[0] < 0) {
    direction = (direction[0] * -1, direction[1], 0);
  }

  grenade.monkey_model utility::function_3677f2be30fdd581("sound", "stolen");
  grenade.monkey_model utility::function_3677f2be30fdd581("vfx", "stolen");
  grenade.monkey_model unlink();
  waitframe();

  if(!isDefined(grenade)) {
    if(isDefined(monkey_model)) {
      monkey_model delete();
    }

    return;
  }

  if(!isDefined(grenade.monkey_model)) {
    return;
  }

  grenade.monkey_model movez(60, 1, 0.25, 0.25);
  grenade.monkey_model vibrate(direction, 1.5, 2.5, 1);
  grenade.monkey_model waittill("movedone");

  if(!isDefined(grenade)) {
    if(isDefined(monkey_model)) {
      monkey_model delete();
    }

    return;
  }

  if(isDefined(grenade.monkey_model)) {
    grenade.monkey_model delete();
  }

  if(isDefined(level.var_38f3f357808bd969) && isDefined(grenade.equipmentref) && isDefined(grenade.owner)) {
    grenade.owner[[level.var_38f3f357808bd969]](grenade.equipmentref, "secondary");
  } else if(function_1d982537b9dcb924(grenade.owner)) {
    itembundlename = function_f3bb4f4911a1beb2("game", "getItemBundleNameFromRef", grenade.equipmentref);

    if(!isDefined(itembundlename)) {
      return;
    }

    itembundle = getscriptbundle("itemspawnentry:" + itembundlename);
    fakeitem = spawnStruct();
    fakeitem.count = 1;
    fakeitem.type = itembundle.scriptable;
    grenade.owner function_f3bb4f4911a1beb2("game", "obtainItemEquip", fakeitem, 0);
  }

  if(isDefined(e_actor)) {
    e_actor delete();
  }

  if(isDefined(grenade)) {
    if(isDefined(grenade.damagearea)) {
      grenade.damagearea delete();
    }

    grenade delete();
  }
}

function function_37ae9ad9c5dea6c2() {
  level endon("game_ended");

  while(true) {
    foreach(monkey_model in level.var_e0b07114267e08bb) {
      if(!isDefined(monkey_model) || istrue(monkey_model.dancing)) {
        continue;
      }

      if(!isDefined(monkey_model.grenade)) {
        if(isDefined(monkey_model.attractor)) {
          remove_attractor(monkey_model.attractor);
        }

        monkey_model delete();
        continue;
      }

      monkey_model thread function_4fd6f1249646368d();
      waitframe();
    }

    level.var_c36f48de0ba87814 = array_removeundefined(level.var_c36f48de0ba87814);
    level.var_e0b07114267e08bb = array_removeundefined(level.var_e0b07114267e08bb);
    waitframe();
  }
}

function function_7119b9ec768ee712(checkloc) {
  if(!isDefined(self.var_154288d91ba8cf1a)) {
    return false;
  }

  squaredist = distancesquared(checkloc, self.var_154288d91ba8cf1a);
  return squaredist <= 40000;
}

function function_4fd6f1249646368d() {
  self endon("death");
  waitframe();
  self.dancing = 1;

  if(isDefined(level.var_fc48fdf7b8edde6c) && ![[level.var_fc48fdf7b8edde6c]](self.origin)) {
    array_remove(level.var_c36f48de0ba87814, self);

    if(isDefined(self.attractor)) {
      remove_attractor(self.attractor);
    }

    level thread grenade_stolen_by_sam(self.grenade, self);
    return;
  }

  thread function_980a6fd749f5e09a();
  utility::function_3677f2be30fdd581("sound", "song");
  self scriptmodelplayanim("jup_zm_monkey_bomb_dance");
  bundle = self.grenade.tableinfo.bundle;
  totalduration = default_to(bundle.var_eb43e84aee7dd355, 8.5);
  totalduration = getdvarfloat(@ "hash_20d07ece0bd25ae4", totalduration);
  var_688feff73f1c40d2 = gettime() + function_a5b14435e3229bed(totalduration);

  while(gettime() < var_688feff73f1c40d2) {
    if(!isDefined(self.grenade)) {
      break;
    }

    waitframe();
  }

  function_cfd45d884eb33a37();
}

function function_980a6fd749f5e09a() {
  self endon("death");
  wait 0.15;
  utility::function_3677f2be30fdd581("vfx", "active");
}

function function_cfd45d884eb33a37() {
  if(isDefined(self.grenade)) {
    self.grenade detonate();
  }

  self.dancing = 0;
}