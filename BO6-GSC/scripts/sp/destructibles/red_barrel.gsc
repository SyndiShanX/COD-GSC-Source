/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\destructibles\red_barrel.gsc
***************************************************/

#using scripts\common\ai;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\destructibles\barrel_common;
#using scripts\sp\loot;
#using scripts\sp\nvg\nvg_ai;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\utility;
#namespace red_barrel;

function red_barrel_init() {
  level.g_effect["\x89arr\xb2\xd8\xbe\x996X[\xb2\xfa\x1d\xb7\x1c"] = loadfxasset("i\xae\xdf\xfdri<'\xbe\xbf\x7fX~)\x1c\x18\"(V\xb0\xff\xb2]\xbd.\xcf\x13\xf5B\x03\xe1\xbc11\xf8\x91\v\xd7\x97\xf8\xa9\xc95\xc3uMf\xd2\x15\xdd\x12\x02N\x85\xe2\ar\xaby#E\xfa");
  level.g_effect[")\xc6\x90\x06\xcf\xee\xf2\xadz\xdey\xeel\f\xef\x9d\x1eZ"] = loadfxasset("\x19\xb3\xfbd\xb7\x92\x81\xf1T\xda\xc8\xb5\xa6\x84\xd1\x85\x1f\xb75\xabQW\x13\xcd\xa7yyup\xf6a\x9a4\x7f\xa2.\xb4'\xb8");
  level.g_effect["d\x10U6BE\x1c=K\x88\ry\xf0/b\xc3"] = loadfxasset("\x1cX\xa3:(\xf0\xe5\xd1\ac.\x80\xcc\xfc\xc6\xa0~\xc7\x84\xa4\x14j\xe0\xd3\x87\r\xccu.\x84\x80]\x03\xdd\x9a\xc4");
  level.g_effect["\xa1\xd0\xeb\xb3}\x12=\x1f\xefv>"] = loadfxasset("\xf8\x9d\x132B\x14\x1c\x8f\xee\xae\xc3\xe9\xfa\x96x\xe7\x1c%\x8d\xff\xfd\xf58~\x9e\xd6\x8d\xa8\xe0\xb8\\&\v\x03&\x9a");
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
  self endon("m\xd9S\xb0\xae%\xc1dt&\xf9,");
  self endon("e]\x99l\xed\x9aV]x\xb5\xf9GP");
  barrel_common::barrel_setup("\x9b\x9b\v", 450, 250, 9100, 15000, 80, 28);
  thread red_barrel_death();
  fusesettime = 999999999;
  timer = 4;
  firetimer = 0;
  self.health = 9450;
  damageattacker = undefined;

  while(true) {
    self waittill("\fU`\xc0y\x95", amount, attacker, direction_vec, point, type, modelname, tagname, partname, dflags, objweapon);

    if(!barrel_common::isvalidbarreldamage(attacker, type)) {
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
        if(soundexists("X\xbb7}*Ei\v\xa0v\x86\xe4\xda\xdd 9\xe0\x875r\xf1\v<\x1dl5\xa2`lT\x93\x88")) {
          thread utility::play_loop_sound_on_entity("X\xbb7}*Ei\v\xa0v\x86\xe4\xda\xdd 9\xe0\x875r\xf1\v<\x1dl5\xa2`lT\x93\x88");
        }

        playFXOnTag(level.g_effect["\xa1\xd0\xeb\xb3}\x12=\x1f\xefv>"], self, "\xec\xbfK|\au\xcd\xc2\x19<");

        if(utility::hastag(self.model, "X\xde8#\xe4\x0e\x0f\xe7p")) {
          playFXOnTag(level.g_effect["\x89arr\xb2\xd8\xbe\x996X[\xb2\xfa\x1d\xb7\x1c"], self, "X\xde8#\xe4\x0e\x0f\xe7p");
        } else {
          playFXOnTag(level.g_effect["\x89arr\xb2\xd8\xbe\x996X[\xb2\xfa\x1d\xb7\x1c"], self, "\xec\xbfK|\au\xcd\xc2\x19<");
        }

        badplace_cylinder("J\x84\xd7\x93\x0e-\xd7\xed#X\xa8\xa0\xb9K\x95\xc5" + self getentitynumber(), 0, self.origin, 128, 128, "\x9a\x1f\x83\x1bs=\x13\xf8");
        firetimer = 1;
        self.onfire = 1;
      }

      timerpercentage = self.barrel_health / 449;
      timepassed = (gettime() - fusesettime) / 1000;

      if(4 * timerpercentage < timer - timepassed) {
        timer = 4 * timerpercentage;
        thread barrel_common::barrel_fusetimer(timer);
        fusesettime = gettime();
      }
    }

    if(isDefined(direction_vec)) {
      velocity = length(direction_vec);

      if(velocity > 20) {
        normalvec = vectorNormalize(direction_vec);
        launchvelocity = 20;

        if(isDefined(type) && type == "M\x81\xaf\xee\xc9\xcfD\xef\x91J") {
          launchvelocity = 3;
        }

        direction_vec = normalvec * launchvelocity;
      }

      self physicslaunchserver(point, direction_vec * 1000);
    }

    if(!isDefined(type)) {
      continue;
    }

    stringarray = strtok(type, "w");

    if(!arraycontains(stringarray, "\xd6\xcb\x8a\xd5\x8a\xb1")) {
      continue;
    }

    tag = utility::spawn_tag_origin(point);
    vec = vectorNormalize(self.origin - point);
    tagangles = vectortoangles(vec * -1);
    tag.angles = utility::flat_angle(tagangles);
    tag linkTo(self);

    if(soundexists("#\xe6t\xf56\xdb7\xd1\xb0i\xb9\xca'\xbe\xed\x87y;+n\xd7b\x16\xc9\x93\xac\xb1_\r\xd27\xdc\xeb\xd8\xdb\xdb\x83")) {
      tag thread utility::play_loop_sound_on_entity("#\xe6t\xf56\xdb7\xd1\xb0i\xb9\xca'\xbe\xed\x87y;+n\xd7b\x16\xc9\x93\xac\xb1_\r\xd27\xdc\xeb\xd8\xdb\xdb\x83");
    }

    playFXOnTag(level.g_effect[")\xc6\x90\x06\xcf\xee\xf2\xadz\xdey\xeel\f\xef\x9d\x1eZ"], tag, "\xec\xbfK|\au\xcd\xc2\x19<");
    self.spewtags = utility::array_add(self.spewtags, tag);
  }

  while(isDefined(self.dont_explode)) {
    waitframe();
  }

  self notify("m\xd9S\xb0\xae%\xc1dt&\xf9,", damageattacker);
}

function barrelshouldexplode(attacker, point, type, objweapon) {
  if(self.barrel_health <= 0) {
    return true;
  }

  if(barrel_common::isgrenadeinrange(point, type, 80)) {
    return true;
  }

  if(barrel_common::isdirectunderbarrelhit(type)) {
    return true;
  }

  if(barrel_common::isplayersniperhit(attacker, objweapon)) {
    return true;
  }

  return false;
}

function red_barrel_death() {
  self endon("e]\x99l\xed\x9aV]x\xb5\xf9GP");
  self waittill("m\xd9S\xb0\xae%\xc1dt&\xf9,", damageattacker);

  if(soundexists("X\xbb7}*Ei\v\xa0v\x86\xe4\xda\xdd 9\xe0\x875r\xf1\v<\x1dl5\xa2`lT\x93\x88") && isDefined(self.onfire) && self.onfire) {
    self notify("y\x9cO.4\xf5\xb1\x19\xa8\xe1" + "X\xbb7}*Ei\v\xa0v\x86\xe4\xda\xdd 9\xe0\x875r\xf1\v<\x1dl5\xa2`lT\x93\x88");
  }

  physicsexplosionsphere(self.origin, self.phys_barrel_radius, 0, 2);
  earthquake(0.5, 0.8, self.origin, 400);
  thread barrel_common::barrel_block_gesture(200, self.origin);
  maxtimer = 0.3;
  barrels = sortbydistance(level.phys_barrels, self.origin);

  foreach(barrel in barrels) {
    if(barrel == self) {
      continue;
    }

    distancefrombarrel = distance(self.origin, barrel.origin);

    if(distancefrombarrel > self.phys_barrel_radius) {
      continue;
    }

    distcheck = self.phys_barrel_radius - distancefrombarrel;
    distpercentage = distcheck / self.phys_barrel_radius;
    timer = maxtimer * distpercentage;

    if(distancefrombarrel <= self.phys_barrel_radius) {
      barrel thread barrel_common::barrel_launch(self.origin, distancefrombarrel, timer);
    }

    if(distancefrombarrel <= 200) {
      barrel thread red_barrel_hit(self.origin, distancefrombarrel, timer);
    }
  }

  veharray = utility_sp::getvehiclearray();

  foreach(veh in veharray) {
    damage = 400;
    var_d7ae273e1c1e122d = 370;

    if(isDefined(veh.script_team) && veh.script_team == "O\x15\x1b\xad\x9ff") {
      continue;
    }

    distancefromveh = distance(self.origin, veh.origin);
    distancefromveh = 0;
    var_14fb5e01770c1ca3 = 490;

    if(distancefromveh <= var_14fb5e01770c1ca3) {
      distpercentage = distancefromveh / var_14fb5e01770c1ca3;
      damage -= distpercentage * var_d7ae273e1c1e122d;

      if(getdvarint(@ "barrel_debug")) {
        iprintln("\xf9\x10 \xb0\xff\xec\\\xe0_~7" + damage + "PC\\\x81\xb4\xd6A");
      }

      veh utility_sp::do_damage(damage, self.origin, self, self, "\xa2rl\xdaDn\x17b\xd9I\xc9=N");
    }
  }

  aiignorearray = getaiarray();

  foreach(ai in aiignorearray) {
    if(!istrue(ai.magic_bullet_shield)) {
      aiignorearray = arrayremove(aiignorearray, ai);
    }
  }

  spheretraces = trace::sphere_trace_get_all_results(self.origin, self.origin, 190, aiignorearray, trace::create_character_contents(), 0);
  var_6e7985f2c9a5184e = 0;

  foreach(spheretrace in spheretraces) {
    spherefraction = spheretrace["\xda\x16\x81\aw}^i"];

    if(isDefined(spherefraction) && spherefraction != 1) {
      sphereentity = spheretrace["\x1f\xa8\x10WP\xa9"];

      if(isai(sphereentity)) {
        var_6e7985f2c9a5184e++;
        isjugg = sphereentity.subclass == "\xab\xbf\xbe\xe2\xcdvJ\x14/c";
        dmgamount = isjugg == 1 ? 1000 : sphereentity.health + 999999;

        if(!isjugg && randomint(100) < 0) {
          thread burnenemy(sphereentity, 1, self.origin);
          continue;
        }

        if(!isjugg && isDefined(level.aigibfunction)) {
          if(isDefined(damageattacker)) {
            damageattacker utility::delaythread(0.15, level.aigibfunction, sphereentity, self.origin, "\xa2rl\xdaDn\x17b\xd9I\xc9=N");
          } else {
            utility::delaythread(0.15, level.aigibfunction, sphereentity, self.origin, "\xa2rl\xdaDn\x17b\xd9I\xc9=N");
          }

          continue;
        }

        sphereentity utility_sp::do_damage(dmgamount, self.origin, self, self, "\xa2rl\xdaDn\x17b\xd9I\xc9=N");
      }
    }
  }

  distancefromplayer = distance(self.origin, level.player.origin);

  if(distancefromplayer <= 200) {
    distpercentage = distancefromplayer / 200;
    var_d7ae273e1c1e122d = 420;
    damage = 420 - distpercentage * var_d7ae273e1c1e122d;

    if(getdvarint(@ "barrel_debug")) {
      iprintln("\xf9\x10 \xb0\xff\xec\\\xe0_~7" + damage + "\x1b\x85\x9ee\xd2\xe2[\xdc\xb0B");
    }

    level.player utility_sp::do_damage(damage, self.origin, self, self, "\xa2rl\xdaDn\x17b\xd9I\xc9=N");
  }

  level notify("\x93+2\xf5&\x16\xe4\xe4\xcac_\xb2\xf0\x83\xb1\xde\x9b\x96{s", self, var_6e7985f2c9a5184e);
  radiusdamage(self.origin, 2, 1, 0, self);
  badplace_delete("J\x84\xd7\x93\x0e-\xd7\xed#X\xa8\xa0\xb9K\x95\xc5" + self getentitynumber());

  if(isDefined(self)) {
    self hide();
  }

  waitframe();

  if(soundexists("F\xdcG\xf5l\xed\xcdGXK\xdc\xb2'\xbe\xde\x0f\xcb\xd9\x95\xcd\xafL\xc2'9\x956}Y\x1e\a\xc6\xf6F\xb2")) {
    thread utility::play_sound_in_space("F\xdcG\xf5l\xed\xcdGXK\xdc\xb2'\xbe\xde\x0f\xcb\xd9\x95\xcd\xafL\xc2'9\x956}Y\x1e\a\xc6\xf6F\xb2", self.origin);
  }

  playFX(level.g_effect["d\x10U6BE\x1c=K\x88\ry\xf0/b\xc3"], self.origin);

  foreach(element in self.spewtags) {
    killfxontag(level.g_effect[")\xc6\x90\x06\xcf\xee\xf2\xadz\xdey\xeel\f\xef\x9d\x1eZ"], element, "\xec\xbfK|\au\xcd\xc2\x19<");
    waitframe();

    if(isDefined(element)) {
      element delete();
    }
  }

  killfxontag(level.g_effect["\xa1\xd0\xeb\xb3}\x12=\x1f\xefv>"], self, "\xec\xbfK|\au\xcd\xc2\x19<");

  if(utility::hastag(self.model, "X\xde8#\xe4\x0e\x0f\xe7p")) {
    killfxontag(level.g_effect["\x89arr\xb2\xd8\xbe\x996X[\xb2\xfa\x1d\xb7\x1c"], self, "X\xde8#\xe4\x0e\x0f\xe7p");
  } else {
    killfxontag(level.g_effect["\x89arr\xb2\xd8\xbe\x996X[\xb2\xfa\x1d\xb7\x1c"], self, "\xec\xbfK|\au\xcd\xc2\x19<");
  }

  waitframe();

  if(isDefined(self)) {
    thread delay_delete(5);
  }
}

function burnenemy(enemy, todeath, origin, molotovowner) {
  if(istrue(enemy.var_c38dfabbf7656462)) {
    todeath = 0;
  }

  enemy._blackboard.isburning = 1;
  enemy.burningtodeath = todeath;
  enemy.burningdirection = undefined;

  if(todeath) {
    if(istrue(enemy.flashlight)) {
      enemy nvg_ai::flashlight_off(0);
    }

    enemy utility_sp::anim_stopanimScripted();
    enemy utility_sp::do_damage(enemy.health + 9999, origin, molotovowner, molotovowner, "\b\x89z\xc1\xf1\xd4I\xf3", "\xb6\xbdc\xf6Gov");
    currentstate = undefined;

    if(enemy isscriptable()) {
      currentstate = enemy getscriptablepartstate("\xadt$xK8e\xd6\x0f5\x80\x1cHB\xf0\r<\x88\xc3h\xc8(e\x9f", 1);
    }

    if(!isDefined(currentstate)) {
      enemy thread burn_sfx(todeath);
    }
  } else {
    enemyright = anglestoright(enemy.angles);
    var_7cebc08296b0b15d = vectorNormalize(origin - enemy.origin);

    if(vectordot(enemyright, var_7cebc08296b0b15d) > 0) {
      enemy.burningdirection = "o0\xee\xc1\x8c";
    } else {
      enemy.burningdirection = "=\xff0b";
    }

    enemy utility_sp::do_damage(1, origin, molotovowner, molotovowner, "\b\x89z\xc1\xf1\xd4I\xf3", "\xb6\xbdc\xf6Gov");
    enemy thread burn_sfx();
  }

  level thread ai::remove_blackboard_isburning(enemy);
}

function burn_sfx(todeath) {
  if(isDefined(todeath)) {
    duration = 1;
  } else {
    duration = 0.5;
  }

  if(!isDefined(self.burnsfxenabled)) {
    self.burnsfxenabled = 0;
  }

  if(!isDefined(self.burnsfx)) {
    burnsfx = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", self.origin);
    burnsfx linkTo(self);
    self.burnsfx = burnsfx;
    wait 0.05;
  } else {
    burnsfx = self.burnsfx;
  }

  if(isDefined(self) && self.burnsfxenabled == 0) {
    burnsfx playLoopSound("Ac\x94\xd7\xc4\xaa\xc71|\xdf\xe3\x85\xab\x1f\xc3\xeb\xa8\x11\x9b\x17\xb8;\xbb\x1f\xf4\xd0xsS\x91 \x01");
    self.burnsfxenabled = 1;
    wait duration;
    burnsfx playSound("\x96\xbd/{YzF\x8e\xf8}dG\x80\x19\xfcy<\xad\xe8l/wx\x98\xff$\x7f\xe2|\x9b\a&\xc32\xec\x19");
    wait 0.15;
    burnsfx stoploopsound("Ac\x94\xd7\xc4\xaa\xc71|\xdf\xe3\x85\xab\x1f\xc3\xeb\xa8\x11\x9b\x17\xb8;\xbb\x1f\xf4\xd0xsS\x91 \x01");
    burnsfx delete();

    if(isDefined(self)) {
      self.burnsfxenabled = 1;
    }
  }
}

function delay_delete(time) {
  wait time;

  if(isDefined(self)) {
    self delete();
  }
}

function red_barrel_hit(explodeorigin, distancefrombarrel, timer) {
  self endon("m\xd9S\xb0\xae%\xc1dt&\xf9,");
  self endon("e]\x99l\xed\x9aV]x\xb5\xf9GP");
  wait timer;

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.onfire)) {
    return;
  }

  maxdamage = 95;
  maxrange = 200;

  if(distancefrombarrel <= 90) {
    minmaxdiff = -878;
    damagemodifier = (90 - distancefrombarrel) / maxrange;
    damage = 1 + damagemodifier * minmaxdiff;
  } else {
    damagemodifier = (maxrange - distancefrombarrel) / maxrange;
    damage = damagemodifier * maxdamage;
  }

  self notify("\fU`\xc0y\x95", damage, undefined, undefined, undefined, "\xa2rl\xdaDn\x17b\xd9I\xc9=N", undefined, undefined, undefined, undefined, undefined);
}

function moltovrefillthink() {
  self.molotovs = getEntArray(self.target, #targetname);
  thread createmoltovinteractwhenavailable();

  while(true) {
    result = utility::waittill_any_return_no_endon_death("\x91`\xb1\xe7T\x97>", "m\xd9S\xb0\xae%\xc1dt&\xf9,", "\x1e\xfd\xd1\xa2\a");

    if(result == "\x91`\xb1\xe7T\x97>") {
      self.interactable = 0;
      molotovrefilltriggerthink();

      if(level.player getammocount("\xb6\xbdc\xf6Gov") == weaponmaxammo("\xb6\xbdc\xf6Gov")) {
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
  barrels = getEntArray("ER\rv_Y\x03*\xeb \ru\xe77\x12\xf7|c\xdf\xaa\x9d\x849\x03", #targetname);

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

  cursor_hint::create_cursor_hint(undefined, (0, 0, 50), &"weapon/label_molotov", 55, 400, 55, 1);
  self.interactable = 1;
}

function removemoltovinteract() {
  if(!isDefined(self.interactable) || !self.interactable) {
    return;
  }

  cursor_hint::remove_cursor_hint();
  self.interactable = 0;
}

function createmoltovinteractwhenavailable() {
  self notify("rF\x01\\\xb2\xf3q\x1a\xe7T\xe6\f\xd8\xae\xfe_\xb1\xfd&\t\xadD\x8a|\xdc\xa4\xfd");
  self endon("\x91`\xb1\xe7T\x97>");
  self endon("m\xd9S\xb0\xae%\xc1dt&\xf9,");
  self endon("rF\x01\\\xb2\xf3q\x1a\xe7T\xe6\f\xd8\xae\xfe_\xb1\xfd&\t\xadD\x8a|\xdc\xa4\xfd");
  self endon("\x1e\xfd\xd1\xa2\a");
  wait 0.05;
  maxammo = weaponmaxammo("\xb6\xbdc\xf6Gov");

  while(true) {
    if(level.player getammocount("\xb6\xbdc\xf6Gov") < maxammo && !ishidden()) {
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

  hideparts = utility::array_add(self.molotovs, self);

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

  showparts = utility::array_add(self.molotovs, self);

  foreach(part in showparts) {
    part show();
    part solid();
  }

  createmoltovinteractwhenavailable();
  self.hidden = 0;
}

function is_molotov_barrel() {
  if(isDefined(self.script_parameters) && self.script_parameters == "\aE\xf0\xc9\x98B^ Y\xce\x04P\xd1\xd0") {
    return true;
  }

  return false;
}

function molotovrefilltriggerthink() {
  offhands = level.player getweaponslistoffhands();

  if(!playerhasmolotovs(offhands)) {
    level.player utility_sp::give_offhand("\xb6\xbdc\xf6Gov");
    level.player setweaponammoclip("\xb6\xbdc\xf6Gov", 0);
  }

  maxammo = weaponmaxammo("\xb6\xbdc\xf6Gov");
  possibleammo = maxammo - level.player getammocount("\xb6\xbdc\xf6Gov");
  ammotaken = min(self.molotovs.size, possibleammo);

  for(i = 0; i < ammotaken; i++) {
    lootoffhandhack();
    self.molotovs[self.molotovs.size - 1] delete();
    self.molotovs = arrayremove(self.molotovs, self.molotovs[self.molotovs.size - 1]);
    wait 0.2;
  }
}

function playerhasmolotovs(offhands) {
  foreach(offhand in offhands) {
    if(offhand.basename == "\xb6\xbdc\xf6Gov") {
      return true;
    }
  }

  return false;
}

function getallredbarrels() {
  return getEntArray("ER\rv_Y\x03*\xeb \ru\xe77\x12\xf7|c\xdf\xaa\x9d\x849\x03", #targetname);
}

function lootoffhandhack() {
  lootname = "\xa6\xbdc\xf6Gov";
  level.player thread[[level.loot.types[lootname].lootfunc]](lootname);
  loot::playlootsound(lootname);

  if(level.loot.types[lootname].createnotification) {
    thread loot::createnotification(lootname);
  }
}