/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\asm\shared\sp\utility.gsc
************************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\asm_sp;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\utility;
#using scripts\sp\art;
#namespace utility;

function loopanimfortime(asmname, statename, params) {
  self endon(statename + "_finished");
  self endon("terminate_ai_threads");
  endevent = "loop_end";
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

  thread function_fb56c9527636713f(asmname, statename, 1);
  wait t;
  asm_fireevent(asmname, endevent);
}

function loopanimfortime_blendspace(asmname, statename, params) {
  self endon(statename + "_finished");
  endevent = "loop_end";
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

  blankindex = asm_lookupanimfromalias(statename, "blank");
  self aisetanim(statename, blankindex);
  thread function_ec21aa2f5413bf19(asmname, statename);
  wait t;
  asm_fireevent(asmname, endevent);
}

function function_ec21aa2f5413bf19(asmname, statename) {
  self endon(statename + "_finished");

  while(true) {
    asm_donotetracks(asmname, statename);
  }
}

function function_ad537378d1e07015(asmname, statename, params) {
  animid = asm_getanim(asmname, statename, params);
  xanim = asm_getxanim(statename, animid);
  self setflaggedanimknob(statename, xanim, 1, 0.2, 1);
  thread function_ec21aa2f5413bf19(asmname, statename);
}

function function_6ddf61e941fd9b74(asmname, statename, params) {
  self endon(statename + "_finished");
  endevent = "loop_end";
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

  animid = asm_getanim(asmname, statename);
  xanim = asm_getxanim(statename, animid);
  self setanimknob(xanim, 1, 0.2, 1);
  thread function_ec21aa2f5413bf19(asmname, statename);
  wait t;
  asm_fireevent(asmname, endevent);
}

function handlenotetrack(note, flagname) {
  switch (note) {
    case #"hash_3f80c02caeb2ec99":
      asm_setupaim(undefined, flagname, 0.3);
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
  return self.currentpose == "crouch";
}

function arrivalhack_emptywait() {
  self waittill(self.a.arrivalasmstatename + "_finished");
}

function animscriptedactor(anime, anim_string, org, animangles, anim_flag) {
  if(isstring(anim_flag)) {
    ent_flag_set(anim_flag);
  }

  callback_name = anime + "_animscripted";
  callback::callback(callback_name);
  self animmode("noclip");
  self orientmode("face angle", self.angles[1]);
  asm_clearfacialanim();
  function_30df7eff2a4557a5("animscripted", anime);
  self notify(anim_string, "end");

  if(isstring(anim_flag)) {
    ent_flag_clear(anim_flag);
  }
}

function delayslowmotion(delay, start, end, time) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait delay;
  setslowmotion(start, end, time);
}

function delaymodifybasefov(delay, fov, time) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait delay;
  level.player modifybasefov(fov, time);
}

function delayenabledof(delay, nearstart, nearend, nearblur, farstart, farend, farblur, time) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait delay;
  scripts\sp\art::dof_enable_script(nearstart, nearend, nearblur, farstart, farend, farblur, time);
}

function delaydisabledof(delay) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait delay;
  scripts\sp\art::dof_disable_script(0.5);
}

#using_animtree("player");

function spawnplayerrig() {
  player_rig = spawn("script_model", level.player.origin);
  player_rig.root = % root;
  player_rig setModel("viewmodel_base_viewhands_iw7");
  player_rig useanimtree(#animtree);
  player_rig hide();
  return player_rig;
}

function playergrabbed(type) {
  level.player val::set("PlayerGrabbed", "action_slot_weapon", 0);

  if(!isDefined(type)) {
    level.player disableweapons();
    level.player disableusability();
    level.player allowstand(1);
    level.player allowcrouch(0);
    level.player allowprone(0);
  } else if(type == "seeker") {
    level.player disableweapons();
    level.player allowstand(1);
    level.player allowcrouch(0);
    level.player allowprone(0);
  } else if(type == "crawlmelee") {
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
  level.player val::reset_all("PlayerGrabbed");
}

function playerhealth() {
  self endon("death");
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
      [[level.gameskill_breath_func]]("breathing_hurt");
    } else {
      self playlocalsound("breathing_hurt");
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
  level.player endon("meleegrab_interupt");
  level.player endon("bt_stop_meleegrab");
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
        level.player notify("bt_meleegrab_slowmo");
        return;
      }
    }

    wait 0.05;
  }

  level.player notify("bt_meleegrab_slowmo");
}

function meleegrab_slowmo(start_delay, end_delay) {
  level.player endon("meleegrab_interupt");
  wait start_delay;
  setslowmotion(1, 0.3, 0.1);

  if(!isDefined(self.melee.countersuccess)) {
    level.player waittill("bt_meleegrab_slowmo");
  } else {
    wait 0.05;
  }

  setslowmotion(0.2, 1, 0.05);
}

function playercounterpress() {
  return isalive(level.player) && level.player meleeButtonPressed();
}

function meleegrab_counterhint(delay, presstime) {
  level.player endon("meleegrab_interupt");
  growtime = 0.2;
  post_growtime = 0.3;
  wait delay - growtime - 0.05;

  if(isDefined(self.melee.meleecounterhint)) {
    self.melee.meleecounterhint destroy();
  }

  self.melee.meleecounterhint = newclienthudelem(level.player);
  self.melee.meleecounterhint.color = (1, 1, 1);
  self.melee.meleecounterhint settext(&"SCRIPT_PLATFORM/HINT_MELEE_COUNTER");
  self.melee.meleecounterhint.x = 0;
  self.melee.meleecounterhint.y = 20;
  self.melee.meleecounterhint.alignx = "center";
  self.melee.meleecounterhint.aligny = "middle";
  self.melee.meleecounterhint.horzalign = "center";
  self.melee.meleecounterhint.vertalign = "middle";
  self.melee.meleecounterhint.foreground = 1;
  self.melee.meleecounterhint.alpha = 0;
  self.melee.meleecounterhint.fontscale = 0.5;
  self.melee.meleecounterhint.hidewhendead = 1;
  self.melee.meleecounterhint.sort = -1;
  self.melee.meleecounterhint endon("death");
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

function function_322d1512ea269744(asmname) {
  wait 1;
  ai_array = getaiarray();
  assert(ai_array.size > 0);
  my_ai = ai_array[0];
  asm = anim.asm[asmname];

  foreach(state in asm.states) {
    if(!isDefined(state.flags) || !(array_contains(state.flags, "<dev string:x1c>") || array_contains(state.flags, "<dev string:x29>"))) {
      continue;
    }

    println("<dev string:x2d>" + statename + "<dev string:x40>");
  }
}

function function_ea262b8e6c281e21(asmname, archetypename) {
  var_681b840dd6c562e5 = asmdevgetallnotetrackaimstates(asmname);

  foreach(statename in var_681b840dd6c562e5) {
    if(issubstr(statename, "<dev string:x56>")) {
      continue;
    }

    aliases = archetypegetaliases(archetypename, statename);
    assertex(isDefined(aliases), "<dev string:x5e>" + statename + "<dev string:x83>" + archetypename);

    foreach(alias in aliases) {
      if(issubstr(alias, "<dev string:x29>") || issubstr(alias, "<dev string:x8c>") || issubstr(alias, "<dev string:x94>")) {
        continue;
      }

      anims = asm_getallanimsforalias(archetypename, statename, alias);

      if(!isDefined(anims)) {
        continue;
      }

      foreach(xanim in anims) {
        function_d6919795e4b24d3a(asmname, statename, xanim, "<dev string:x99>");
      }
    }
  }
}

function function_969c8ea16543f26d(asmname, arcname) {
  allstates = asmdevgetallstates(asmname);
  numstates = allstates.size;

  for(istate = 0; istate < numstates; istate++) {
    if(!isDefined(self asmgetfacialstate(asmname, allstates[istate]))) {
      println(asmname + "<dev string:xa3>" + allstates[istate]);
    }
  }
}

function function_ceb59058efc7858b(asmname, archetypename) {
  wait 1;
  ai_array = getaiarray();
  assert(ai_array.size > 0);
  my_ai = ai_array[0];
  asm = anim.asm[asmname];

  foreach(statename, state in asm.states) {
    if(!issubstr(statename, "<dev string:xb6>")) {
      continue;
    }

    aliases = archetypegetaliases(archetypename, statename);

    if(!isDefined(aliases) || aliases.size == 0) {
      continue;
    }

    foreach(alias in aliases) {
      if(issubstr(alias, "<dev string:x29>") || issubstr(alias, "<dev string:x8c>") || issubstr(alias, "<dev string:x94>")) {
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
        println("<dev string:xbc>" + statename + "<dev string:xc3>" + alias + "<dev string:xcb>");
        continue;
      }

      foreach(anime in anim_array) {
        times = getnotetracktimes(anime, "<dev string:xe6>");

        if(!isDefined(times) || times.size == 0) {
          println("<dev string:xf4>" + anime + "<dev string:xf5>");
          continue;
        }

        animlength = getanimlength(anime);
        maxtime = (animlength - 0.1) / animlength;

        if(times[0] > maxtime) {
          println("<dev string:xf4>" + anime + "<dev string:x120>");
        }
      }
    }
  }
}

function function_9a0d30b3528b29(asmname, archetypename) {
  wait 1;
  ai_array = getaiarray();
  assert(ai_array.size > 0);
  my_ai = ai_array[0];
  asm = anim.asm[asmname];

  foreach(statename, state in asm.states) {
    if(issubstr(statename, "<dev string:x161>")) {
      continue;
    }

    var_43c4faf3b0fd2017 = issubstr(statename, "<dev string:x169>");
    var_f727dc9919983e6d = issubstr(statename, "<dev string:x16e>") && !issubstr(statename, "<dev string:x176>");
    var_4d34e80030b6c0d8 = issubstr(statename, "<dev string:x17d>") && !issubstr(statename, "<dev string:x176>");

    if(issubstr(statename, "<dev string:x182>") && !var_43c4faf3b0fd2017) {
      continue;
    }

    if(!var_43c4faf3b0fd2017 && !var_f727dc9919983e6d && !var_4d34e80030b6c0d8) {
      continue;
    }

    aliases = archetypegetaliases(archetypename, statename);

    if(!isDefined(aliases) || aliases.size == 0) {
      continue;
    }

    foreach(alias in aliases) {
      if(issubstr(alias, "<dev string:x29>") || issubstr(alias, "<dev string:x8c>") || issubstr(alias, "<dev string:x94>")) {
        continue;
      }

      if((var_f727dc9919983e6d || var_4d34e80030b6c0d8) && !(issubstr(alias, "<dev string:x18a>") || issubstr(alias, "<dev string:x18c>") || issubstr(alias, "<dev string:x18e>"))) {
        continue;
      }

      if(var_43c4faf3b0fd2017 && issubstr(alias, "<dev string:x17d>")) {
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
        println("<dev string:xbc>" + statename + "<dev string:xc3>" + alias + "<dev string:xcb>");
        continue;
      }

      foreach(anime in anim_array) {
        times = getnotetracktimes(anime, "<dev string:x190>");

        if(!isDefined(times) || times.size == 0) {
          if(var_4d34e80030b6c0d8) {
            times = getnotetracktimes(anime, "<dev string:x197>");

            if(!isDefined(times) || times.size == 0) {
              println("<dev string:xf4>" + anime + "<dev string:x1a2>");
            } else {
              println("<dev string:xf4>" + anime + "<dev string:x1c6>");
            }
          } else {
            println("<dev string:xf4>" + anime + "<dev string:x1a2>");
          }

          continue;
        }

        animlength = getanimlength(anime);
        maxtime = (animlength - 0.1) / animlength;

        if(times[0] > maxtime) {
          println("<dev string:xf4>" + anime + "<dev string:x208>");
        }
      }
    }
  }
}

function function_ebb317bec1d342d8(asmname, archetypename) {
  wait 1;
  ai_array = getaiarray();
  assert(ai_array.size > 0);
  my_ai = ai_array[0];
  asm = anim.asm[asmname];

  foreach(statename, state in asm.states) {
    if(issubstr(statename, "<dev string:x161>")) {
      continue;
    }

    var_43c4faf3b0fd2017 = issubstr(statename, "<dev string:x169>");
    var_f727dc9919983e6d = issubstr(statename, "<dev string:x16e>") && !issubstr(statename, "<dev string:x176>");
    var_4d34e80030b6c0d8 = issubstr(statename, "<dev string:x17d>") && !issubstr(statename, "<dev string:x176>");

    if(issubstr(statename, "<dev string:x182>") && !var_43c4faf3b0fd2017) {
      continue;
    }

    if(!var_43c4faf3b0fd2017 && !var_f727dc9919983e6d && !var_4d34e80030b6c0d8) {
      continue;
    }

    aliases = archetypegetaliases(archetypename, statename);

    if(!isDefined(aliases) || aliases.size == 0) {
      continue;
    }

    foreach(alias in aliases) {
      if(issubstr(alias, "<dev string:x29>") || issubstr(alias, "<dev string:x8c>") || issubstr(alias, "<dev string:x94>")) {
        continue;
      }

      if((var_f727dc9919983e6d || var_4d34e80030b6c0d8) && !(issubstr(alias, "<dev string:x18a>") || issubstr(alias, "<dev string:x18c>") || issubstr(alias, "<dev string:x18e>"))) {
        continue;
      }

      if(var_43c4faf3b0fd2017 && issubstr(alias, "<dev string:x17d>")) {
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
        println("<dev string:xbc>" + statename + "<dev string:xc3>" + alias + "<dev string:xcb>");
        continue;
      }

      foreach(anime in anim_array) {
        times = getnotetracktimes(anime, "<dev string:x190>");

        if(!isDefined(times) || times.size == 0) {
          if(var_4d34e80030b6c0d8) {
            times = getnotetracktimes(anime, "<dev string:x197>");

            if(!isDefined(times) || times.size == 0) {
              println("<dev string:xf4>" + anime + "<dev string:x1a2>");
            } else {
              println("<dev string:xf4>" + anime + "<dev string:x1c6>");
            }
          } else {
            println("<dev string:xf4>" + anime + "<dev string:x1a2>");
          }

          continue;
        }

        animlength = getanimlength(anime);
        maxtime = (animlength - 0.1) / animlength;

        if(times[0] > maxtime) {
          println("<dev string:xf4>" + anime + "<dev string:x208>");
        }
      }
    }
  }
}

# /