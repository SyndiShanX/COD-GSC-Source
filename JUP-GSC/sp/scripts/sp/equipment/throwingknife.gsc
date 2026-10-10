/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\equipment\throwingknife.gsc
*****************************************************/

#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\loot;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace throwingknife;

function precache(offhand) {
  setdvarifuninitialized(@ "hash_425b104730459f47", 0);

  setdvarifuninitialized(@ "hash_a8d9e3f367c7effc", 0);

  registeroffhandfirefunc(offhand, &throwingknifefiremain);
}

function throwingknifefiremain(grenade, weapon) {
  if(!isDefined(grenade)) {
    return;
  }

  grenade.targetname = "offhand_throwingknife";

  if(getdvarint(@ "hash_425b104730459f47") == 1) {
    grenade hudoutline_enable("outline_depth_cyan");
  }

  grenade waittill("missile_stuck", stuckto, stuckpart, null, null, position, normal);

  if(isDefined(stuckpart) && function_28eeffcb2337321e(stuckpart)) {
    stuckpart = function_f28fd66285fa2c9(stuckpart);
  }

  if(isDefined(stuckto) && isai(stuckto)) {
    if(isDefined(stuckpart)) {
      stuckto do_damage(2000, position, level.player, grenade, "MOD_IMPACT", weapon.basename, stuckpart);
    } else {
      stuckto do_damage(2000, position, level.player, grenade, "MOD_IMPACT", weapon.basename);
    }
  }

  grenade hide();
  var_a2301015c1ab039e = grenade.origin;
  var_a2301015c1ab039e += rotatevector((2, 0, 0), grenade.angles);
  var_9770ec8f19981834 = vectortoangles(-1 * normal);
  var_840da51fcf30ff7e = scripts\sp\loot::spawnlootitem("throwingknife", var_a2301015c1ab039e, var_9770ec8f19981834, 0, 1, !isDefined(stuckto), isDefined(stuckto));

  if(isDefined(stuckto) && !isai(stuckto)) {
    var_840da51fcf30ff7e linkTo(stuckto);
  }

  var_840da51fcf30ff7e thread function_4158556b23018384(weapon);
  grenade delete();
}

function function_4158556b23018384(var_626f13d105079101) {
  self endon("delete");
  self makeunusable();
  scripts\sp\player\cursor_hint::remove_cursor_hint();
  trigger = spawn("trigger_radius", self.origin, 0, 64, 64);
  trigger.targetname = "dropped_knife";
  trigger enablelinkTo();
  trigger linkTo(self);
  self.knife_trigger = trigger;
  function_c48e47edf7202570(var_626f13d105079101);
}

function function_c48e47edf7202570(var_626f13d105079101) {
  lootname = ter_op(var_626f13d105079101.basename == "throwingknife_kitchen", "Kitchen Throwing Knife", "Throwing Knife");

  while(true) {
    self.knife_trigger waittill("trigger", player);

    if(!isDefined(player)) {
      break;
    }

    if(isPlayer(player)) {
      if(scripts\sp\loot::getoffhandcurrentammo("throwingknife") < scripts\sp\loot::function_57888d406854dc7f("throwingknife")) {
        weaponname = scripts\sp\loot::getoffhandweaponname("throwingknife");

        if(player_has_equipment(weaponname)) {
          scripts\sp\loot::lootfuncandnotification("throwingknife");
          function_47048f2dd7d4d220();
          player notify("player_throwingKnifePickedUp");
          break;
        }
      }

      if(level.script == "wounded") {
        player notify("throwingknife_pickup_add_to_crafting_inventory", self);
      }
    }
  }
}

function function_47048f2dd7d4d220() {
  if(isDefined(self.knife_trigger)) {
    self.knife_trigger delete();
  }

  self delete();
}

function function_77f29d1ed8e5ad4c() {
  while(true) {
    sphere(self.origin, 64);
    waitframe();
  }
}

function function_73b30a27a6d8f81c() {
  var_375c5ff0a6f238ac = function_9d30fd63965bafa9("bullet", self);

  if(isDefined(level.stealth)) {
    var_375c5ff0a6f238ac = function_61b03c8c194a6733(ter_op(flag("stealth_spotted"), "spotted", "hidden"), "bullet");
  }

  var_fbe5ade21bd0d394 = var_375c5ff0a6f238ac * var_375c5ff0a6f238ac;
  self endon("missile_stuck");
  startpos = self.origin;
  endpos = startpos;
  throwangles = level.player getgunangles();
  minzoffset = 18;
  maxzoffset = 60;
  increment = (maxzoffset - minzoffset) / 2;
  var_e36f4333eb9fdaf4 = [];

  if(getdvarint(@ "hash_a8d9e3f367c7effc")) {
    thread draw_line_for_time(startpos + anglestoright(throwangles) * 1000, startpos + anglestoleft(throwangles) * 1000, 1, 0, 1, 10);
  }

  waitframe();

  while(isDefined(self)) {
    startpos = endpos;
    endpos = self.origin;
    throwangles = vectortoangles(endpos - startpos);
    var_6df2b5e4b03e9ea = vectortoangles(startpos - endpos);

    if(getdvarint(@ "hash_a8d9e3f367c7effc")) {
      thread draw_line_for_time(endpos + anglestoright(var_6df2b5e4b03e9ea) * 1000, endpos + anglestoleft(var_6df2b5e4b03e9ea) * 1000, 1, 1, 0, 10);
    }

    foreach(guy in getaiarray("axis", "team3")) {
      if(array_contains(var_e36f4333eb9fdaf4, guy)) {
        continue;
      }

      max_z = guy.origin[2] + maxzoffset;
      origin = guy.origin + (0, 0, minzoffset);

      while(origin[2] <= max_z) {
        success = 0;

        if(distancesquared(origin, endpos) <= var_fbe5ade21bd0d394) {
          success = 1;

          if(getdvarint(@ "hash_a8d9e3f367c7effc")) {
            thread draw_circle(endpos, var_375c5ff0a6f238ac, (1, 1, 1), 1, 0, 200);
          }
        }

        if(!success) {
          if(!within_fov(startpos, throwangles, origin, 0)) {
            goto LOC_00000381;
          }

          jumpiftrue(within_fov(endpos, var_6df2b5e4b03e9ea, origin, 0)) LOC_0000029c;
        } else {
          LOC_0000029c: if(!success) {
            vector = vectorfromlinetopoint(startpos, endpos, origin);
            success = lengthsquared(vector) <= var_fbe5ade21bd0d394;

            if(success && getdvarint(@ "hash_a8d9e3f367c7effc")) {
              thread draw_line_for_time(startpos, endpos, 1, 1, 1, 10);
              thread draw_line_for_time(origin, origin - vector, 1, 0, 0, 10);
              thread draw_line_for_time(origin - vector, endpos, 1, 0.5, 0, 10);
              thread draw_circle(origin, 5, (1, 0, 0), 1, 0, 200);
            }
          }

          if(success) {
            guy notify("bulletwhizby", level.player, distance(endpos, origin), endpos, endpos - startpos);

            if(isDefined(guy.stealth)) {
              guy aieventlistenerevent("bulletwhizby", level.player, endpos);
            }

            var_e36f4333eb9fdaf4[var_e36f4333eb9fdaf4.size] = guy;
            break;
          }
          LOC_00000381:
        }

        LOC_00000381:
          origin += (0, 0, increment);
      }
    }

    waitframe();
  }
}

function broadcastimpact() {
  ais = getaiunittypearray("bad_guys");
  impactdist = function_9d30fd63965bafa9("silenced_shot_impact", self);
  impactdistsq = squared(impactdist);

  foreach(ai in ais) {
    if(!isalive(ai)) {
      continue;
    }

    if(distancesquared(ai.origin, self.origin) > impactdistsq) {
      continue;
    }

    if(!ai hastacvis(self.origin)) {
      continue;
    }

    ai aieventlistenerevent("silenced_shot_impact", self, self.origin);
  }
}