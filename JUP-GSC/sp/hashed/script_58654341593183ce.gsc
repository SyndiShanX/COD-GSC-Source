/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_58654341593183ce.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace namespace_ae17a10c354d4089;

function function_2ac4b666d5219b3c(var_ece4cdb6e5aa8b4a, ender) {
  function_3926a6002a412c22();

  level.var_42a0de9b6ef45996 = getEntArray("combat_vfx_trig", "targetname");
  function_9d2d988a229aeefc();

  if(isDefined(var_ece4cdb6e5aa8b4a)) {
    new_array = [];

    foreach(trig in level.var_42a0de9b6ef45996) {
      if(is_equal(trig.script_parameters, var_ece4cdb6e5aa8b4a)) {
        new_array[new_array.size] = trig;
      }
    }

    level.var_42a0de9b6ef45996 = new_array;
  }

  array_thread(level.var_42a0de9b6ef45996, &function_3cbd0507936f4d6a, ender);

  foreach(trigger in level.var_42a0de9b6ef45996) {
    thread function_7127726a38749691(trigger, ender);
  }
}

function function_9d2d988a229aeefc() {
  if(flag("combat_vfx_validated")) {
    return;
  }

  for(i = 0; i < level.var_42a0de9b6ef45996.size; i++) {
    assertex(isDefined(level.var_42a0de9b6ef45996[i].script_noteworthy), "Combat VFX found trigger_multiple without a script_noteworthy for its ID.");

    for(j = i + 1; j < level.var_42a0de9b6ef45996.size; j++) {
      assertex(!is_equal(level.var_42a0de9b6ef45996[i].script_noteworthy, level.var_42a0de9b6ef45996[j].script_noteworthy), "Trigger_multiples used in Combat VFX need to have unique ids. Found duplicate of " + level.var_42a0de9b6ef45996[i].script_noteworthy);
    }
  }

  flag_set("combat_vfx_validated");
}

function function_3cbd0507936f4d6a(ender) {
  if(isDefined(ender)) {
    level endon(ender);
    thread function_95b56106b7e85116(ender);
  }

  var_d7f06a752628b6fa = self.script_noteworthy + "_combat_react_1";
  var_d7f069752628b4c7 = self.script_noteworthy + "_combat_react_2";
  var_d7f068752628b294 = self.script_noteworthy + "_combat_react_3";
  self.var_b680c10324473f8c = 0;
  var_26b869f78156526c = 0;

  while(true) {
    self.var_b680c10324473f8c = ter_op(self.var_b680c10324473f8c > 20, 20, self.var_b680c10324473f8c);
    self.var_b680c10324473f8c = ter_op(self.var_b680c10324473f8c < 0, 0, self.var_b680c10324473f8c);

    if(self.var_b680c10324473f8c > 0 && !istrue(level.var_92d377698c995c23)) {
      self.var_b680c10324473f8c--;
    }

    if(self.var_b680c10324473f8c > var_26b869f78156526c) {
      if(var_26b869f78156526c < 5 && self.var_b680c10324473f8c >= 5) {
        exploder(var_d7f06a752628b6fa);

        function_20f62f1a0552371e("<dev string:x1c>" + var_d7f06a752628b6fa);
      }

      if(var_26b869f78156526c < 10 && self.var_b680c10324473f8c >= 10) {
        exploder(var_d7f069752628b4c7);

        function_20f62f1a0552371e("<dev string:x1c>" + var_d7f069752628b4c7);
      }

      if(var_26b869f78156526c < 15 && self.var_b680c10324473f8c >= 15) {
        exploder(var_d7f068752628b294);

        function_20f62f1a0552371e("<dev string:x1c>" + var_d7f068752628b294);
      }
    } else {
      if(var_26b869f78156526c >= 15 && self.var_b680c10324473f8c < 15) {
        stop_exploder(var_d7f068752628b294);

        function_20f62f1a0552371e("<dev string:x2a>" + var_d7f068752628b294);
      }

      if(var_26b869f78156526c >= 10 && self.var_b680c10324473f8c < 10) {
        stop_exploder(var_d7f069752628b4c7);

        function_20f62f1a0552371e("<dev string:x2a>" + var_d7f069752628b4c7);
      }

      if(var_26b869f78156526c >= 5 && self.var_b680c10324473f8c < 5) {
        stop_exploder(var_d7f06a752628b6fa);

        function_20f62f1a0552371e("<dev string:x2a>" + var_d7f06a752628b6fa);
      }
    }

    var_26b869f78156526c = self.var_b680c10324473f8c;
    wait 2;
  }
}

function function_95b56106b7e85116(ender) {
  level waittill(ender);

  function_20f62f1a0552371e("<dev string:x39>" + self.script_noteworthy);

  var_d7f06a752628b6fa = self.script_noteworthy + "_1";
  var_d7f069752628b4c7 = self.script_noteworthy + "_2";
  var_d7f068752628b294 = self.script_noteworthy + "_3";
  stop_exploder(var_d7f06a752628b6fa);
  stop_exploder(var_d7f069752628b4c7);
  stop_exploder(var_d7f068752628b294);
}

function function_7127726a38749691(trigger, ender) {
  trigger.entstouching = [];
  thread function_517f189c3fd702(trigger, ender);
  thread function_5a85956055e327dc(trigger, ender);
}

function function_5a85956055e327dc(trigger, ender) {
  if(isDefined(ender)) {
    level endon(ender);
  }

  level endon("game_ended");

  while(true) {
    trigger waittill("trigger", ent);

    if(!isPlayer(ent) && !isagent(ent)) {
      continue;
    }

    function_5925d73a990557b7(trigger, ent, ender);
  }
}

function function_517f189c3fd702(trigger, ender) {
  if(isDefined(ender)) {
    level endon(ender);
  }

  level endon("game_ended");

  while(true) {
    temparr = trigger.entstouching;

    foreach(ent in temparr) {
      if(!isDefined(ent)) {
        trigger.entstouching[id] = undefined;
      }

      if(isDefined(ent) && !trigger istouching(ent) || !isalive(ent)) {
        function_5e42d1f88a8eca33(trigger, ent);
      }
    }

    waitframe();
  }
}

function function_5925d73a990557b7(trigger, ent, ender) {
  entnum = ent getentitynumber();

  if(isDefined(trigger.entstouching[entnum])) {
    return;
  }

  trigger.entstouching[entnum] = ent;
  thread function_fdcd6ad88960131f(trigger, ent, ender);
}

function function_fdcd6ad88960131f(trigger, ent, ender) {
  if(isDefined(ender)) {
    level endon(ender);
  }

  ent endon("death");
  ent endon("kill_combat_vfx_watcher_" + trigger.script_noteworthy);

  while(true) {
    ent waittill_any_2("weapon_fired", "grenade_fire");
    trigger.var_b680c10324473f8c++;
  }
}

function function_5e42d1f88a8eca33(trigger, ent) {
  entnum = ent getentitynumber();
  trigger.entstouching[entnum] = undefined;
  ent notify("kill_combat_vfx_watcher_" + trigger.script_noteworthy);
}

function function_3926a6002a412c22() {
  while(!isDefined(level.player)) {
    wait 1;
  }

  if(getdvarint(@ "hash_604330adc1c5db54", 0) == 0) {
    return;
  }

  if(istrue(level.var_7a62b7c85c409f4b)) {
    return;
  }

  thread function_426a2c8ae3cc270e();
  thread function_40c2769c9f6d7439();
  thread function_b687445b2e08970c();
  level.var_7a62b7c85c409f4b = 1;
}

function function_426a2c8ae3cc270e() {
  text = newhudelem();
  text.alignx = "<dev string:x4c>";
  text.aligny = "<dev string:x51>";
  text.x = -30;
  text.y = 60;
  text.sort = 5;
  text.fontscale = 0.8;
  text.alpha = 0.5;

  while(true) {
    while(!isDefined(level.var_42a0de9b6ef45996)) {
      wait 0.1;
    }

    var_601ecb0bd8d0667 = [];
    vol_name = "<dev string:x55>";
    var_7d694ccd315bea32 = "<dev string:x55>";
    var_207254c3e531b5d8 = "<dev string:x55>";

    foreach(vol in level.var_42a0de9b6ef45996) {
      if(level.player istouching(vol)) {
        var_601ecb0bd8d0667[var_601ecb0bd8d0667.size] = vol;
      }
    }

    foreach(var_cf9b2c884573be8e in var_601ecb0bd8d0667) {
      vol_name += var_cf9b2c884573be8e.script_noteworthy + "<dev string:x56>";
      var_7d694ccd315bea32 += var_cf9b2c884573be8e.var_b680c10324473f8c + "<dev string:x56>";
      var_207254c3e531b5d8 += var_cf9b2c884573be8e.entstouching.size + "<dev string:x56>";
    }

    string = "<dev string:x55>";
    string += "<dev string:x58>" + level.var_42a0de9b6ef45996.size;
    string += "<dev string:x72>" + vol_name;
    string += "<dev string:x85>" + var_7d694ccd315bea32;
    string += "<dev string:x95>" + var_207254c3e531b5d8;

    if(istrue(level.var_92d377698c995c23)) {
      string += "<dev string:xad>";
    }

    text setdevtext(string);
    waitframe();
  }
}

function function_40c2769c9f6d7439() {
  while(true) {
    if(!isDefined(level.var_42a0de9b6ef45996)) {
      wait 1;
    }

    foreach(vol in level.var_42a0de9b6ef45996) {
      if(level.player istouching(vol) || function_7b985bb4ab71a39b(vol.origin, 80)) {
        print3d(vol.origin, vol.script_noteworthy + "<dev string:x56>" + vol.var_b680c10324473f8c, (0.9, 0.9, 1), 0.9, 0.5, undefined, 1);
        drawentitybounds(vol, (0.9, 0.9, 1), 0);
        continue;
      }

      depth_test = !getdvarint(@ "hash_39550553300ebd06", 0);
      print3d(vol.origin, vol.script_noteworthy + "<dev string:x56>" + vol.var_b680c10324473f8c, (0.8, 0.8, 1), 0.8, 0.5, undefined, 1);
      drawentitybounds(vol, (0.7, 0.7, 1), depth_test);
    }

    waitframe();
  }
}

function function_7b985bb4ab71a39b(origin, var_7c20ec2b664f4326) {
  screenpos = level.player worldpointtoscreenpos(origin, getdvarfloat(@ "hash_b38fcf293d1e91a8"));

  if(isDefined(screenpos)) {
    dist = length2dsquared(screenpos);

    if(dist <= var_7c20ec2b664f4326) {
      return 1;
    }
  }

  return 0;
}

function function_b687445b2e08970c() {
  level.player notifyonplayercommand("<dev string:xbc>", "<dev string:xcb>");
  level.player notifyonplayercommand("<dev string:xbc>", "<dev string:xd6>");
  level.player notifyonplayercommand("<dev string:xe0>", "<dev string:xef>");
  level.player notifyonplayercommand("<dev string:xe0>", "<dev string:xfd>");
  level.player notifyonplayercommand("<dev string:x10b>", "<dev string:x11e>");
  level.var_92d377698c995c23 = 0;

  while(true) {
    results = level.player waittill_any_return_3("<dev string:xbc>", "<dev string:xe0>", "<dev string:x10b>");
    var_27007b92b5a6193 = undefined;

    foreach(trig in level.var_42a0de9b6ef45996) {
      if(level.player istouching(trig)) {
        var_27007b92b5a6193 = trig;
      }
    }

    if(!isDefined(var_27007b92b5a6193)) {
      var_27007b92b5a6193 = getclosest(level.player.origin, level.var_42a0de9b6ef45996);
    }

    switch (results) {
      case #"hash_2c1d9c0f575728a9":
        var_27007b92b5a6193.var_b680c10324473f8c++;
        break;
      case #"hash_be694beb8a541855":
        var_27007b92b5a6193.var_b680c10324473f8c--;
        break;
      case #"hash_70b4432f4442f0db":
        level.var_92d377698c995c23 = !level.var_92d377698c995c23;

        if(level.var_92d377698c995c23) {
          iprintln("<dev string:x12a>");
        } else {
          iprintln("<dev string:x143>");
        }

        break;
    }
  }
}

function function_20f62f1a0552371e(print_text) {
  if(getdvarint(@ "hash_604330adc1c5db54", 0) == 1) {
    iprintln(print_text);
  }
}

# /