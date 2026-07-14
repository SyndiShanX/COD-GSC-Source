/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\shared\sp\utility.gsc
*********************************************/

#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\engine\utility;
#using scripts\sp\art;
#namespace utility;

function loopanimfortime(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self endon("b\xf7PR\xf8L\xaf8\xf4\xdd\x97\x1f\xe8\xcb7\x1dUG\x02\xba");
  endevent = "D\xa6\a]\xb23\xf1\f";
  t = 2;

  if(isarray(params)) {
    if(params.size > 0) {
      t = params[0];
    }

    if(params.size > 1) {
      endevent = params[1];
    }
  } else {
    t = params;
  }

  thread asm::function_1be97a4513bb86d2(asmname, statename, 1);
  wait t;
  asm::asm_fireevent(asmname, endevent);
}

function loopanimfortime_blendspace(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  endevent = "D\xa6\a]\xb23\xf1\f";
  t = 2;

  if(isarray(params)) {
    if(params.size > 0) {
      t = params[0];
    }

    if(params.size > 1) {
      endevent = params[1];
    }
  } else {
    t = params;
  }

  blankindex = asm::asm_lookupanimfromalias(statename, "\x9a\x93\xb5\xc4I");
  self aisetanim(statename, blankindex);
  thread function_16b0b968ca805824(asmname, statename);
  wait t;
  asm::asm_fireevent(asmname, endevent);
}

function function_16b0b968ca805824(asmname, statename) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  while(true) {
    asm::asm_donotetracks(asmname, statename);
  }
}

function function_c559dd3a7518d170(asmname, statename, params) {
  animid = asm::asm_getanim(asmname, statename, params);
  xanim = asm::asm_getxanim(statename, animid);
  self setflaggedanimknob(statename, xanim, 1, 0.2, 1);
  thread function_16b0b968ca805824(asmname, statename);
}

function function_7543f5ebb11c3e95(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  endevent = "D\xa6\a]\xb23\xf1\f";
  t = 2;

  if(isarray(params)) {
    if(params.size > 0) {
      t = params[0];
    }

    if(params.size > 1) {
      endevent = params[1];
    }
  } else {
    t = params;
  }

  animid = asm::asm_getanim(asmname, statename);
  xanim = asm::asm_getxanim(statename, animid);
  self setanimknob(xanim, 1, 0.2, 1);
  thread function_16b0b968ca805824(asmname, statename);
  wait t;
  asm::asm_fireevent(asmname, endevent);
}

function handlenotetrack(note, flagname) {
  switch (note) {
    case #"hash_3f80c02caeb2ec99":
      asm::asm_setupaim(undefined, flagname, 0.3);
      break;
  }
}

function asm_powerdown() {
  self.bpowerdown = 1;
}

function asm_powerup() {
  self.bpowerdown = undefined;
}

function wantstocrouch() {
  return self.currentpose == "1x\xc5\xb4\xabx";
}

function arrivalhack_emptywait() {
  self waittill(self.a.arrivalasmstatename + "\x1b\xe0K\x01;P\xfdf\x98");
}

function animscriptedactor(anime, anim_string, org, animangles, anim_flag) {
  if(isstring(anim_flag)) {
    ent_flag_set(anim_flag);
  }

  callback_name = anime + "2]\x03\x88H\xe7\xde\xcd\"j\x96M\x8e";
  callback::callback(callback_name);
  self animmode("b\xf21\xbc\xeb{");
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
  asm::asm_clearfacialanim();
  asm::function_52226c4f9ee0a74c("\x13\xf2\xf7\xd7\\p\xa8j\xed\xb7\xbe\x9b", anime);
  self notify(anim_string, "8\xdb\x90");

  if(isstring(anim_flag)) {
    ent_flag_clear(anim_flag);
  }
}

function delayslowmotion(delay, start, end, time) {
  level.player endon("\x94\x11\xa5\xf3BS\x8a9\xea\xf1%9\xf77\x16\xf5xb");
  level.player endon("nt\x89\x01|dwP*ckdGjfl\xacU\x8d\x13\xe5{2^");
  wait delay;
  setslowmotion(start, end, time);
}

function delaymodifybasefov(delay, fov, time) {
  level.player endon("\x94\x11\xa5\xf3BS\x8a9\xea\xf1%9\xf77\x16\xf5xb");
  level.player endon("nt\x89\x01|dwP*ckdGjfl\xacU\x8d\x13\xe5{2^");
  wait delay;
  level.player modifybasefov(fov, time);
}

function delayenabledof(delay, nearstart, nearend, nearblur, farstart, farend, farblur, time) {
  level.player endon("\x94\x11\xa5\xf3BS\x8a9\xea\xf1%9\xf77\x16\xf5xb");
  level.player endon("nt\x89\x01|dwP*ckdGjfl\xacU\x8d\x13\xe5{2^");
  wait delay;
  art::dof_enable_script(nearstart, nearend, nearblur, farstart, farend, farblur, time);
}

function delaydisabledof(delay) {
  level.player endon("\x94\x11\xa5\xf3BS\x8a9\xea\xf1%9\xf77\x16\xf5xb");
  level.player endon("nt\x89\x01|dwP*ckdGjfl\xacU\x8d\x13\xe5{2^");
  wait delay;
  art::dof_disable_script(0.5);
}

#using_animtree("K_p\x84a\x01");

function spawnplayerrig() {
  player_rig = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", level.player.origin);
  player_rig.root = % \x11\x9ag\xc4;
  player_rig setModel("\xf5\xa3V\xc5\xed\xaf@\xabke-\xef\xfb\x1f\x06\xf9\x88\x85?\xce\xb1\xd63\x8d\xbe\xba8\x04");
  player_rig useanimtree(#animtree);
  player_rig hide();
  return player_rig;
}

function playergrabbed(type) {
  level.player val::set(".\xbac\xa0\x99\xa9\x84\xe8Pl-\xd9\xcd", "\xc2\xb4B\x81\a\xba|>M\xf8\x87\x04@n\xddy\a_", 0);

  if(!isDefined(type)) {
    level.player disableweapons();
    level.player disableusability();
    level.player allowstand(1);
    level.player allowcrouch(0);
    level.player allowprone(0);
  } else if(type == "r\x16W\xd7@~") {
    level.player disableweapons();
    level.player allowstand(1);
    level.player allowcrouch(0);
    level.player allowprone(0);
  } else if(type == "\x8eH+G\xf2`\x14\xfe\xb3\x0e") {
    level.player disableusability();
    level.player allowstand(0);
    level.player allowcrouch(1);
    level.player allowprone(0);
  }

  level.player allowoffhandshieldweapons(0);
  level.player enableslowaim(0.2, 0.5);
}

function playerletgo() {
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player enableweapons();
  level.player allowoffhandshieldweapons(1);
  level.player disableslowaim();
  level.player enableusability();
  level.player val::reset_all(".\xbac\xa0\x99\xa9\x84\xe8Pl-\xd9\xcd");
}

function playerhealth() {
  self endon("\x1e\xfd\xd1\xa2\a");
  wait 0.2;
  time = 3;
  timer = gettime() + time * 1000;
  self.health_overlay.alpha += (1 - level.player.health_overlay.alpha) * 0.8;
  self.health_overlay fadeovertime(3);
  self.health_overlay.alpha = 0;

  while(gettime() < timer) {
    if(self.health <= 0) {
      return;
    }

    if(isDefined(self.disable_breathing_sound) && self.disable_breathing_sound) {
      continue;
    }

    if(isDefined(level.gameskill_breath_func)) {
      [[level.gameskill_breath_func]]("\xaf\t\xbe\xbd\xae\a\x81\v]\xc4\r\x87\x7f\x82");
    } else {
      self playlocalsound("\xaf\t\xbe\xbd\xae\a\x81\v]\xc4\r\x87\x7f\x82");
    }

    breathing_time = 0.1;
    wait breathing_time + randomfloat(0.8);
  }
}

function meleegrab_common() {
  self.hackable = 0;
  self.bmeleeinprogress = 1;

  if(isDefined(anim)) {
    if(isPlayer(self.meleetarget)) {
      anim.meleechargeplayertimers[self.unittype] = gettime() + anim.meleechargeplayerintervals[self.unittype];
      return;
    }

    anim.meleechargetimers[self.unittype] = gettime() + anim.meleechargeintervals[self.unittype];
  }
}

function meleegrab_counterinput(animtime) {
  level.player endon("\x94\x11\xa5\xf3BS\x8a9\xea\xf1%9\xf77\x16\xf5xb");
  level.player endon("&\x1d\xafn\x1d\xde\x0e\xd7k\xb2\x1bY\xca\x9d\xe4a\x89");
  countertime = 0.5;
  time = gettime();
  start_delay = animtime - countertime;
  start_time = time + start_delay * 1000;
  end_delay = animtime;
  end_time = time + end_delay * 1000;
  thread meleegrab_slowmo(start_delay, end_delay);
  thread meleegrab_counterhint(start_delay, countertime);

  while(playercounterpress()) {
    wait 0.05;
  }

  for(;;) {
    time = gettime();

    if(time >= end_time) {
      break;
    }

    if(playercounterpress()) {
      if(time > start_time && time < end_time) {
        if(isDefined(self.melee.meleecounterhint)) {
          level.player thread counterhintdestroy(0.1);
        }

        self.melee.countersuccess = 1;
        level.player notify("\x13\xa3\xd7kYc\xca+\x9dNX&\xfa\xdc\xc6{\xdd\xb5\xf6");
        return;
      }
    }

    wait 0.05;
  }

  level.player notify("\x13\xa3\xd7kYc\xca+\x9dNX&\xfa\xdc\xc6{\xdd\xb5\xf6");
}

function meleegrab_slowmo(start_delay, end_delay) {
  level.player endon("\x94\x11\xa5\xf3BS\x8a9\xea\xf1%9\xf77\x16\xf5xb");
  wait start_delay;
  setslowmotion(1, 0.3, 0.1);

  if(!isDefined(self.melee.countersuccess)) {
    level.player waittill("\x13\xa3\xd7kYc\xca+\x9dNX&\xfa\xdc\xc6{\xdd\xb5\xf6");
  } else {
    wait 0.05;
  }

  setslowmotion(0.2, 1, 0.05);
}

function playercounterpress() {
  return isalive(level.player) && level.player meleeButtonPressed();
}

function meleegrab_counterhint(delay, presstime) {
  level.player endon("\x94\x11\xa5\xf3BS\x8a9\xea\xf1%9\xf77\x16\xf5xb");
  growtime = 0.2;
  post_growtime = 0.3;
  wait delay - growtime - 0.05;

  if(isDefined(self.melee.meleecounterhint)) {
    self.melee.meleecounterhint destroy();
  }

  self.melee.meleecounterhint = newclienthudelem(level.player);
  self.melee.meleecounterhint.color = (1, 1, 1);
  self.melee.meleecounterhint settext(&"script_platform/hint_melee_counter");
  self.melee.meleecounterhint.x = 0;
  self.melee.meleecounterhint.y = 20;
  self.melee.meleecounterhint.alignx = "O\xd5!\xe8\xd4\x9d";
  self.melee.meleecounterhint.aligny = "#\xb8\xfd\xf5\x1a@";
  self.melee.meleecounterhint.horzalign = "O\xd5!\xe8\xd4\x9d";
  self.melee.meleecounterhint.vertalign = "#\xb8\xfd\xf5\x1a@";
  self.melee.meleecounterhint.foreground = 1;
  self.melee.meleecounterhint.alpha = 0;
  self.melee.meleecounterhint.fontscale = 0.5;
  self.melee.meleecounterhint.hidewhendead = 1;
  self.melee.meleecounterhint.sort = -1;
  self.melee.meleecounterhint endon("\x1e\xfd\xd1\xa2\a");
  self.melee.meleecounterhint fadeovertime(growtime);
  self.melee.meleecounterhint changefontscaleovertime(growtime);
  self.melee.meleecounterhint.fontscale = 1.3;
  self.melee.meleecounterhint.alpha = 1;
  wait growtime;

  if(!isDefined(self.melee.meleecounterhint)) {
    return;
  }

  self.melee.meleecounterhint fadeovertime(post_growtime);
  self.melee.meleecounterhint changefontscaleovertime(post_growtime);
  self.melee.meleecounterhint.fontscale = 1.2;
}

function meleeset(asmname, statename, params) {
  return isDefined(level.player.melee.countersuccess);
}

function meleecountered(asmname, statename, params) {
  return isDefined(level.player.melee.countersuccess) && level.player.melee.countersuccess;
}

function meleecounteredfailed(asmname, statename, params) {
  return isDefined(level.player.melee.countersuccess) && !level.player.melee.countersuccess;
}

function counterhintdestroy(fade) {
  if(isDefined(fade)) {
    level.player.melee.meleecounterhint fadeovertime(fade);
    level.player.melee.meleecounterhint changefontscaleovertime(fade);
    level.player.melee.meleecounterhint.fontscale = 2;
    level.player.melee.meleecounterhint.alpha = 0;
    wait fade;
  }

  if(level.player.in_melee && isDefined(level.player.melee.meleecounterhint)) {
    level.player.melee.meleecounterhint destroy();
  }
}

function function_768d1ada0a10f8a9(asmname) {
  wait 1;
  ai_array = getaiarray();
  assert(ai_array.size > 0);
  my_ai = ai_array[0];
  asm = anim.asm[asmname];

  foreach(state in asm.states) {
    if(!isDefined(state.flags) || !(arraycontains(state.flags, "<dev string:x24>") || arraycontains(state.flags, "<dev string:x34>"))) {
      continue;
    }

    println("<dev string:x3b>" + statename + "<dev string:x51>");
  }
}

function function_b54e27609c0d254(asmname, archetypename) {
  var_e11f4602ae889a28 = asmdevgetallnotetrackaimstates(asmname);

  foreach(statename in var_e11f4602ae889a28) {
    if(issubstr(statename, "<dev string:x6a>")) {
      continue;
    }

    aliases = archetypegetaliases(archetypename, statename);
    assert(isDefined(aliases), "<dev string:x75>" + statename + "<dev string:x9d>" + archetypename);

    foreach(alias in aliases) {
      if(issubstr(alias, "<dev string:x34>") || issubstr(alias, "<dev string:xa9>") || issubstr(alias, "<dev string:xb4>")) {
        continue;
      }

      anims = asm::asm_getallanimsforalias(archetypename, statename, alias);

      if(!isDefined(anims)) {
        continue;
      }

      foreach(xanim in anims) {
        function_d597cacc88fd453b(asmname, statename, xanim, "<dev string:xbc>");
      }
    }
  }
}

function function_6365298c837f54f8(asmname, arcname) {
  allstates = asmdevgetallstates(asmname);
  numstates = allstates.size;

  for(istate = 0; istate < numstates; istate++) {
    if(!isDefined(self asmgetfacialstate(asmname, allstates[istate]))) {
      println(asmname + "<dev string:xc9>" + allstates[istate]);
    }
  }
}

function function_ddc44abdc914bf46(asmname, archetypename) {
  wait 1;
  ai_array = getaiarray();
  assert(ai_array.size > 0);
  my_ai = ai_array[0];
  asm = anim.asm[asmname];

  foreach(statename, state in asm.states) {
    if(!issubstr(statename, "<dev string:xdf>")) {
      continue;
    }

    aliases = archetypegetaliases(archetypename, statename);

    if(!isDefined(aliases) || aliases.size == 0) {
      continue;
    }

    foreach(alias in aliases) {
      if(issubstr(alias, "<dev string:x34>") || issubstr(alias, "<dev string:xa9>") || issubstr(alias, "<dev string:xb4>")) {
        continue;
      }

      anim_array = undefined;
      animstruct = archetypegetalias(archetypename, statename, alias, 0);

      if(isDefined(animstruct)) {
        if(!isarray(animstruct.anims)) {
          anim_array[0] = animstruct.anims;
        } else {
          anim_array = animstruct.anims;
        }
      }

      animstruct = archetypegetalias(archetypename, statename, alias, 1);

      if(isDefined(animstruct)) {
        if(!isarray(animstruct.anims)) {
          anim_array[anim_array.size] = animstruct.anims;
        } else {
          anim_array = array_combine_unique(anim_array, animstruct.anims);
        }
      }

      if(!isDefined(anim_array) || anim_array.size == 0) {
        println("<dev string:xe8>" + statename + "<dev string:xf2>" + alias + "<dev string:xfd>");
        continue;
      }

      foreach(anime in anim_array) {
        times = getnotetracktimes(anime, "<dev string:x11b>");

        if(!isDefined(times) || times.size == 0) {
          println("<dev string:x12c>" + anime + "<dev string:x130>");
          continue;
        }

        animlength = getanimlength(anime);
        maxtime = (animlength - 0.1) / animlength;

        if(times[0] > maxtime) {
          println("<dev string:x12c>" + anime + "<dev string:x15e>");
        }
      }
    }
  }
}

function function_3a771bd4312ab470(asmname, archetypename) {
  wait 1;
  ai_array = getaiarray();
  assert(ai_array.size > 0);
  my_ai = ai_array[0];
  asm = anim.asm[asmname];

  foreach(statename, state in asm.states) {
    if(issubstr(statename, "<dev string:x1a2>")) {
      continue;
    }

    var_7d98fc305aa3921e = issubstr(statename, "<dev string:x1ad>");
    var_5b6089fc1e689610 = issubstr(statename, "<dev string:x1b5>") && !issubstr(statename, "<dev string:x1c0>");
    var_3cebd7bd614fa69 = issubstr(statename, "<dev string:x1ca>") && !issubstr(statename, "<dev string:x1c0>");

    if(issubstr(statename, "<dev string:x1d2>") && !var_7d98fc305aa3921e) {
      continue;
    }

    if(!var_7d98fc305aa3921e && !var_5b6089fc1e689610 && !var_3cebd7bd614fa69) {
      continue;
    }

    aliases = archetypegetaliases(archetypename, statename);

    if(!isDefined(aliases) || aliases.size == 0) {
      continue;
    }

    foreach(alias in aliases) {
      if(issubstr(alias, "<dev string:x34>") || issubstr(alias, "<dev string:xa9>") || issubstr(alias, "<dev string:xb4>")) {
        continue;
      }

      if((var_5b6089fc1e689610 || var_3cebd7bd614fa69) && !(issubstr(alias, "<dev string:x1dd>") || issubstr(alias, "<dev string:x1e2>") || issubstr(alias, "<dev string:x1e7>"))) {
        continue;
      }

      if(var_7d98fc305aa3921e && issubstr(alias, "<dev string:x1ca>")) {
        continue;
      }

      anim_array = undefined;
      animstruct = archetypegetalias(archetypename, statename, alias, 0);

      if(isDefined(animstruct)) {
        if(!isarray(animstruct.anims)) {
          anim_array[0] = animstruct.anims;
        } else {
          anim_array = animstruct.anims;
        }
      }

      animstruct = archetypegetalias(archetypename, statename, alias, 1);

      if(isDefined(animstruct)) {
        if(!isarray(animstruct.anims)) {
          anim_array[anim_array.size] = animstruct.anims;
        } else {
          anim_array = array_combine_unique(anim_array, animstruct.anims);
        }
      }

      if(!isDefined(anim_array) || anim_array.size == 0) {
        println("<dev string:xe8>" + statename + "<dev string:xf2>" + alias + "<dev string:xfd>");
        continue;
      }

      foreach(anime in anim_array) {
        times = getnotetracktimes(anime, "<dev string:x1ec>");

        if(!isDefined(times) || times.size == 0) {
          if(var_3cebd7bd614fa69) {
            times = getnotetracktimes(anime, "<dev string:x1f6>");

            if(!isDefined(times) || times.size == 0) {
              println("<dev string:x12c>" + anime + "<dev string:x204>");
            } else {
              println("<dev string:x12c>" + anime + "<dev string:x22b>");
            }
          } else {
            println("<dev string:x12c>" + anime + "<dev string:x204>");
          }

          continue;
        }

        animlength = getanimlength(anime);
        maxtime = (animlength - 0.1) / animlength;

        if(times[0] > maxtime) {
          println("<dev string:x12c>" + anime + "<dev string:x270>");
        }
      }
    }
  }
}

function function_e78a631d11083f9(asmname, archetypename) {
  wait 1;
  ai_array = getaiarray();
  assert(ai_array.size > 0);
  my_ai = ai_array[0];
  asm = anim.asm[asmname];

  foreach(statename, state in asm.states) {
    if(issubstr(statename, "<dev string:x1a2>")) {
      continue;
    }

    var_7d98fc305aa3921e = issubstr(statename, "<dev string:x1ad>");
    var_5b6089fc1e689610 = issubstr(statename, "<dev string:x1b5>") && !issubstr(statename, "<dev string:x1c0>");
    var_3cebd7bd614fa69 = issubstr(statename, "<dev string:x1ca>") && !issubstr(statename, "<dev string:x1c0>");

    if(issubstr(statename, "<dev string:x1d2>") && !var_7d98fc305aa3921e) {
      continue;
    }

    if(!var_7d98fc305aa3921e && !var_5b6089fc1e689610 && !var_3cebd7bd614fa69) {
      continue;
    }

    aliases = archetypegetaliases(archetypename, statename);

    if(!isDefined(aliases) || aliases.size == 0) {
      continue;
    }

    foreach(alias in aliases) {
      if(issubstr(alias, "<dev string:x34>") || issubstr(alias, "<dev string:xa9>") || issubstr(alias, "<dev string:xb4>")) {
        continue;
      }

      if((var_5b6089fc1e689610 || var_3cebd7bd614fa69) && !(issubstr(alias, "<dev string:x1dd>") || issubstr(alias, "<dev string:x1e2>") || issubstr(alias, "<dev string:x1e7>"))) {
        continue;
      }

      if(var_7d98fc305aa3921e && issubstr(alias, "<dev string:x1ca>")) {
        continue;
      }

      anim_array = undefined;
      animstruct = archetypegetalias(archetypename, statename, alias, 0);

      if(isDefined(animstruct)) {
        if(!isarray(animstruct.anims)) {
          anim_array[0] = animstruct.anims;
        } else {
          anim_array = animstruct.anims;
        }
      }

      animstruct = archetypegetalias(archetypename, statename, alias, 1);

      if(isDefined(animstruct)) {
        if(!isarray(animstruct.anims)) {
          anim_array[anim_array.size] = animstruct.anims;
        } else {
          anim_array = array_combine_unique(anim_array, animstruct.anims);
        }
      }

      if(!isDefined(anim_array) || anim_array.size == 0) {
        println("<dev string:xe8>" + statename + "<dev string:xf2>" + alias + "<dev string:xfd>");
        continue;
      }

      foreach(anime in anim_array) {
        times = getnotetracktimes(anime, "<dev string:x1ec>");

        if(!isDefined(times) || times.size == 0) {
          if(var_3cebd7bd614fa69) {
            times = getnotetracktimes(anime, "<dev string:x1f6>");

            if(!isDefined(times) || times.size == 0) {
              println("<dev string:x12c>" + anime + "<dev string:x204>");
            } else {
              println("<dev string:x12c>" + anime + "<dev string:x22b>");
            }
          } else {
            println("<dev string:x12c>" + anime + "<dev string:x204>");
          }

          continue;
        }

        animlength = getanimlength(anime);
        maxtime = (animlength - 0.1) / animlength;

        if(times[0] > maxtime) {
          println("<dev string:x12c>" + anime + "<dev string:x270>");
        }
      }
    }
  }
}

# /