/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\destructibles\red_barrel.gsc
******************************************************/

#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\destructibles\barrel_common;
#using scripts\sp\equipment\molotov;
#using scripts\sp\loot;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace red_barrel;

function red_barrel_init() {
  level.g_effect["barrel_flame_top"] = loadfx("vfx/iw7/levels/moon/scripted/scriptables/oxygen_tank/vfx_oxygen_tank_spewing_flames.vfx");
  level.g_effect["barrel_flame_small"] = loadfx("vfx/iw8/prop/scriptables/vfx_dest_barrel_fire_sm.vfx");
  level.g_effect["barrel_explosion"] = loadfx("vfx/iw8/prop/scriptables/vfx_red_barrel_exp.vfx");
  level.g_effect["barrel_fire"] = loadfx("vfx/iw8/prop/scriptables/vfx_dest_barrel_fire.vfx");
  barrels = getallredbarrels();

  foreach(barrel in barrels) {
    if(barrel is_molotov_barrel()) {
      barrel thread moltovrefillthink();
      continue;
    }

    barrel thread red_barrel();
  }
}

function red_barrel() {
  self endon("barrel_death");
  self endon("barrel_delete");
  barrel_setup("red", 450, 250, 9100, 15000, 80, 28);
  thread red_barrel_death();
  var_db7ee9acb96d930d = 999999999;
  timer = 4;
  firetimer = 0;
  self.health = 9450;
  damageattacker = undefined;

  while(true) {
    self waittill("damage", amount, attacker, direction_vec, point, type, modelname, tagname, partname, dflags, objweapon);

    if(!isvalidbarreldamage(attacker, type)) {
      self.health += amount;
      continue;
    }

    damageattacker = attacker;
    self.barrel_health = self.health - 9000;

    if(barrelshouldexplode(attacker, point, type, objweapon)) {
      break;
    }

    if(self.barrel_health <= 449) {
      if(!firetimer) {
        if(soundexists("o2_barrel_fire")) {
          thread play_loop_sound_on_entity("o2_barrel_fire");
        }

        playFXOnTag(level.g_effect["barrel_fire"], self, "tag_origin");

        if(hastag(self.model, "tag_valve")) {
          playFXOnTag(level.g_effect["barrel_flame_top"], self, "tag_valve");
        } else {
          playFXOnTag(level.g_effect["barrel_flame_top"], self, "tag_origin");
        }

        badplace_cylinder("barrel_badplace_" + self getentitynumber(), 0, self.origin, 128, 128, "bad_guys");
        firetimer = 1;
        self.onfire = 1;
      }

      timerpercentage = self.barrel_health / 449;
      timepassed = (gettime() - var_db7ee9acb96d930d) / 1000;

      if(4 * timerpercentage < timer - timepassed) {
        timer = 4 * timerpercentage;
        thread barrel_fusetimer(timer);
        var_db7ee9acb96d930d = gettime();
      }
    }

    if(isDefined(direction_vec)) {
      velocity = length(direction_vec);

      if(velocity > 20) {
        normalvec = vectorNormalize(direction_vec);
        launchvelocity = 20;

        if(isDefined(type) && type == "MOD_IMPACT") {
          launchvelocity = 3;
        }

        direction_vec = normalvec * launchvelocity;
      }

      self physicslaunchserver(point, direction_vec * 1000);
    }

    if(!isDefined(type)) {
      continue;
    }

    stringarray = strtok(type, "_");

    if(!array_contains(stringarray, "BULLET")) {
      continue;
    }

    tag = spawn_tag_origin(point);
    vec = vectorNormalize(self.origin - point);
    tagangles = vectortoangles(vec * -1);
    tag.angles = flat_angle(tagangles);
    tag linkTo(self);

    if(soundexists("o2_barrel_hiss_loop")) {
      tag thread play_loop_sound_on_entity("o2_barrel_hiss_loop");
    }

    playFXOnTag(level.g_effect["barrel_flame_small"], tag, "tag_origin");
    self.spewtags = array_add(self.spewtags, tag);
  }

  while(isDefined(self.dont_explode)) {
    waitframe();
  }

  self notify("barrel_death", damageattacker);
}

function barrelshouldexplode(attacker, point, type, objweapon) {
  if(self.barrel_health <= 0) {
    return true;
  }

  if(isgrenadeinrange(point, type, 80)) {
    return true;
  }

  if(isdirectunderbarrelhit(type)) {
    return true;
  }

  if(isplayersniperhit(attacker, objweapon)) {
    return true;
  }

  return false;
}

function red_barrel_death() {
  self endon("barrel_delete");
  self waittill("barrel_death", damageattacker);

  if(soundexists("o2_barrel_fire") && isDefined(self.onfire) && self.onfire) {
    self notify("stop sound" + "o2_barrel_fire");
  }

  physicsexplosionsphere(self.origin, self.phys_barrel_radius, 0, 2);
  earthquake(0.5, 0.8, self.origin, 400);
  thread barrel_block_gesture(200, self.origin);
  maxtimer = 0.3;
  barrels = sortbydistance(level.phys_barrels, self.origin);

  foreach(barrel in barrels) {
    if(barrel == self) {
      continue;
    }

    var_d062fa74a20c4a2 = distance(self.origin, barrel.origin);

    if(var_d062fa74a20c4a2 > self.phys_barrel_radius) {
      continue;
    }

    distcheck = self.phys_barrel_radius - var_d062fa74a20c4a2;
    distpercentage = distcheck / self.phys_barrel_radius;
    timer = maxtimer * distpercentage;

    if(var_d062fa74a20c4a2 <= self.phys_barrel_radius) {
      barrel thread barrel_launch(self.origin, var_d062fa74a20c4a2, timer);
    }

    if(var_d062fa74a20c4a2 <= 200) {
      barrel thread red_barrel_hit(self.origin, var_d062fa74a20c4a2, timer);
    }
  }

  veharray = getvehiclearray();

  foreach(veh in veharray) {
    damage = 400;
    var_f5d54f342fb4a774 = 370;

    if(isDefined(veh.script_team) && veh.script_team == "allies") {
      continue;
    }

    var_3a18862e89749191 = distance(self.origin, veh.origin);
    var_3a18862e89749191 = 0;

    if(var_3a18862e89749191 <= 19000) {
      distpercentage = var_3a18862e89749191 / 190 * 100;
      damage -= distpercentage * var_f5d54f342fb4a774;

      if(getdvarint(@ "barrel_debug")) {
        iprintln("BARREL DID " + damage + " TO VEH");
      }

      veh do_damage(damage, self.origin, self, self, "MOD_EXPLOSIVE");
    }
  }

  var_e5cff7e645b201da = getaiarray();

  foreach(ai in var_e5cff7e645b201da) {
    if(!istrue(ai.magic_bullet_shield)) {
      var_e5cff7e645b201da = array_remove(var_e5cff7e645b201da, ai);
    }
  }

  spheretraces = sphere_trace_get_all_results(self.origin, self.origin, 190, var_e5cff7e645b201da, create_character_contents(), 0);
  var_88e03175e378817 = 0;

  foreach(spheretrace in spheretraces) {
    spherefraction = spheretrace["fraction"];

    if(isDefined(spherefraction) && spherefraction != 1) {
      sphereentity = spheretrace["entity"];

      if(isai(sphereentity)) {
        var_88e03175e378817++;
        var_c1e36d012dad1782 = is_equal(sphereentity.subclass, "juggernaut");
        dmgamount = ter_op(var_c1e36d012dad1782 == 1, 1000, sphereentity.health + 999999);

        if(!var_c1e36d012dad1782 && randomint(100) < 0) {
          thread scripts\sp\equipment\molotov::molotovburnenemy(sphereentity, 1, self.origin);
          continue;
        }

        if(!var_c1e36d012dad1782 && isDefined(level.aigibfunction)) {
          if(isDefined(damageattacker)) {
            damageattacker delaythread(0.15, level.aigibfunction, sphereentity, self.origin, "MOD_EXPLOSIVE");
          } else {
            delaythread(0.15, level.aigibfunction, sphereentity, self.origin, "MOD_EXPLOSIVE");
          }

          continue;
        }

        sphereentity do_damage(dmgamount, self.origin, self, self, "MOD_EXPLOSIVE");
      }
    }
  }

  var_2d58e8aae155cc83 = distance(self.origin, level.player.origin);

  if(var_2d58e8aae155cc83 <= 200) {
    distpercentage = var_2d58e8aae155cc83 / 200;
    var_f5d54f342fb4a774 = 420;
    damage = 420 - distpercentage * var_f5d54f342fb4a774;

    if(getdvarint(@ "barrel_debug")) {
      iprintln("BARREL DID " + damage + " TO PLAYER");
    }

    level.player do_damage(damage, self.origin, self, self, "MOD_EXPLOSIVE");
  }

  level notify("red_barrel_explosion", self, var_88e03175e378817);
  radiusdamage(self.origin, 2, 1, 0, self);
  badplace_delete("barrel_badplace_" + self getentitynumber());

  if(isDefined(self)) {
    self hide();
  }

  waitframe();

  if(soundexists("o2_barrel_explode")) {
    thread play_sound_in_space("o2_barrel_explode", self.origin);
  }

  playFX(level.g_effect["barrel_explosion"], self.origin);

  foreach(element in self.spewtags) {
    killfxontag(level.g_effect["barrel_flame_small"], element, "tag_origin");
    waitframe();

    if(isDefined(element)) {
      element delete();
    }
  }

  killfxontag(level.g_effect["barrel_fire"], self, "tag_origin");

  if(hastag(self.model, "tag_valve")) {
    killfxontag(level.g_effect["barrel_flame_top"], self, "tag_valve");
  } else {
    killfxontag(level.g_effect["barrel_flame_top"], self, "tag_origin");
  }

  waitframe();

  if(isDefined(self)) {
    thread delay_delete(5);
  }
}

function delay_delete(time) {
  wait time;

  if(isDefined(self)) {
    self delete();
  }
}

function red_barrel_hit(explodeorigin, var_d062fa74a20c4a2, timer) {
  self endon("barrel_death");
  self endon("barrel_delete");
  wait timer;

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.onfire)) {
    return;
  }

  maxdamage = 95;
  maxrange = 200;

  if(var_d062fa74a20c4a2 <= 90) {
    var_2b308f611603de0 = -878;
    damagemodifier = (90 - var_d062fa74a20c4a2) / maxrange;
    damage = 1 + damagemodifier * var_2b308f611603de0;
  } else {
    damagemodifier = (maxrange - var_d062fa74a20c4a2) / maxrange;
    damage = damagemodifier * maxdamage;
  }

  self notify("damage", damage, undefined, undefined, undefined, "MOD_EXPLOSIVE", undefined, undefined, undefined, undefined, undefined);
}

function moltovrefillthink() {
  self.molotovs = getEntArray(self.target, "targetname");
  thread createmoltovinteractwhenavailable();

  while(true) {
    result = waittill_any_return_no_endon_death("trigger", "barrel_death", "death");

    if(result == "trigger") {
      self.interactable = 0;
      molotovrefilltriggerthink();

      if(level.player getammocount("molotov") == weaponmaxammo("molotov")) {
        removeallmolotovinteractsuntilavailable();
      }
    } else {
      removemoltovinteract();

      foreach(molotov in self.molotovs) {
        if(isDefined(molotov)) {
          molotov delete();
        }
      }

      break;
    }

    if(self.molotovs.size == 0) {
      break;
    }
  }
}

function removeallmolotovinteractsuntilavailable() {
  barrels = getEntArray("phys_barrel_destructible", "targetname");

  foreach(barrel in barrels) {
    if(barrel is_molotov_barrel()) {
      barrel removemoltovinteract();
      barrel thread createmoltovinteractwhenavailable();
    }
  }
}

function createmoltovinteract() {
  if(isDefined(self.interactable) && self.interactable) {
    return;
  }

  if(self.molotovs.size == 0) {
    return;
  }

  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 50), &"WEAPON/LABEL_MOLOTOV", 55, 400, 55, 1);
  self.interactable = 1;
}

function removemoltovinteract() {
  if(!isDefined(self.interactable) || !self.interactable) {
    return;
  }

  scripts\sp\player\cursor_hint::remove_cursor_hint();
  self.interactable = 0;
}

function createmoltovinteractwhenavailable() {
  self notify("wait_for_interact_available");
  self endon("trigger");
  self endon("barrel_death");
  self endon("wait_for_interact_available");
  self endon("death");
  wait 0.05;
  maxammo = weaponmaxammo("molotov");

  while(true) {
    if(level.player getammocount("molotov") < maxammo && !ishidden()) {
      break;
    }

    wait 0.1;
  }

  createmoltovinteract();
}

function ishidden() {
  if(isDefined(self.hidden) && self.hidden) {
    return true;
  }

  return false;
}

function molotov_refill_hide() {
  if(!is_molotov_barrel()) {
    return;
  }

  if(ishidden()) {
    return;
  }

  hideparts = array_add(self.molotovs, self);

  foreach(part in hideparts) {
    part hide();
    part notsolid();
  }

  removemoltovinteract();
  self.hidden = 1;
}

function molotov_refill_show() {
  if(!is_molotov_barrel()) {
    return;
  }

  if(!ishidden()) {
    return;
  }

  showparts = array_add(self.molotovs, self);

  foreach(part in showparts) {
    part show();
    part solid();
  }

  createmoltovinteractwhenavailable();
  self.hidden = 0;
}

function is_molotov_barrel() {
  if(isDefined(self.script_parameters) && self.script_parameters == "molotov_refill") {
    return true;
  }

  return false;
}

function molotovrefilltriggerthink() {
  offhands = level.player getweaponslistoffhands();

  if(!playerhasmolotovs(offhands)) {
    level.player give_offhand("molotov");
    level.player setweaponammoclip("molotov", 0);
  }

  maxammo = weaponmaxammo("molotov");
  possibleammo = maxammo - level.player getammocount("molotov");
  ammotaken = min(self.molotovs.size, possibleammo);

  for(i = 0; i < ammotaken; i++) {
    lootoffhandhack();
    self.molotovs[self.molotovs.size - 1] delete();
    self.molotovs = array_remove(self.molotovs, self.molotovs[self.molotovs.size - 1]);
    wait 0.2;
  }
}

function playerhasmolotovs(offhands) {
  foreach(offhand in offhands) {
    if(offhand.basename == "molotov") {
      return true;
    }
  }

  return false;
}

function getallredbarrels() {
  return getEntArray("phys_barrel_destructible", "targetname");
}

function lootoffhandhack() {
  lootname = "Molotov";
  level.player thread[[level.loot.types[lootname].lootfunc]](lootname);
  scripts\sp\loot::playlootsound(lootname);

  if(level.loot.types[lootname].createnotification) {
    thread scripts\sp\loot::createnotification(lootname);
  }
}