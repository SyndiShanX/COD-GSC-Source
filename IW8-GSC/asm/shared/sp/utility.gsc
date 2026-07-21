/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\shared\sp\utility.gsc
***********************************************/

loopanimfortime(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self endon("terminate_ai_threads");
  var_3 = "loop_end";
  var_4 = 2;

  if(isarray(var_2)) {
    if(var_2.size > 0)
      var_4 = var_2[0];

    if(var_2.size > 1)
      var_3 = var_2[1];
  } else
    var_4 = var_2;

  thread scripts\asm\asm::asm_loopanimstate(var_0, var_1, 1);
  wait(var_4);
  scripts\asm\asm::asm_fireevent(var_0, var_3);
}

handlenotetrack(var_0, var_1) {
  switch (var_0) {
    case "start_aim":
      scripts\asm\asm::asm_setupaim(undefined, var_1, 0.3);
      break;
  }
}

asm_powerdown() {
  self.bpowerdown = 1;
}

asm_powerup() {
  self.bpowerdown = undefined;
}

wantstocrouch() {
  return self.currentpose == "crouch";
}

arrivalhack_emptywait() {
  self waittill(self.a.arrivalasmstatename + "_finished");
}

delayslowmotion(var_0, var_1, var_2, var_3) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait(var_0);
  setslowmotion(var_1, var_2, var_3);
}

delaymodifybasefov(var_0, var_1, var_2) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait(var_0);
  level.player modifybasefov(var_1, var_2);
}

delayenabledof(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait(var_0);
  scripts\sp\art::dof_enable_script(var_1, var_2, var_3, var_4, var_5, var_6, var_7);
}

delaydisabledof(var_0) {
  level.player endon("meleegrab_interupt");
  level.player endon("crawlmeleegrab_interrupt");
  wait(var_0);
  scripts\sp\art::dof_disable_script(0.5);
}

#using_animtree("player");

spawnplayerrig() {
  var_0 = spawn("script_model", level.player.origin);
  var_0.root = % root;
  var_0 setModel("viewmodel_base_viewhands_iw7");
  var_0 useanimtree(#animtree);
  var_0 hide();
  return var_0;
}

playergrabbed(var_0) {
  level.player scripts\engine\sp\utility::allow_action_slot_weapon(0);

  if(!isDefined(var_0)) {
    level.player disableweapons();
    level.player disableusability();
    level.player allowstand(1);
    level.player allowcrouch(0);
    level.player allowprone(0);
  } else if(var_0 == "seeker") {
    level.player disableweapons();
    level.player allowstand(1);
    level.player allowcrouch(0);
    level.player allowprone(0);
  } else if(var_0 == "crawlmelee") {
    level.player disableusability();
    level.player allowstand(0);
    level.player allowcrouch(1);
    level.player allowprone(0);
  }

  level.player allowoffhandshieldweapons(0);
  level.player enableslowaim(0.2, 0.5);
}

playerletgo() {
  level.player allowstand(1);
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player enableweapons();
  level.player allowoffhandshieldweapons(1);
  level.player disableslowaim();
  level.player enableusability();
  level.player scripts\engine\sp\utility::allow_action_slot_weapon(1);
}

playerhealth() {
  self endon("death");
  wait 0.2;
  var_0 = 3;
  var_1 = gettime() + var_0 * 1000;
  self.health_overlay.alpha = self.health_overlay.alpha + (1 - level.player.health_overlay.alpha) * 0.8;
  self.health_overlay fadeovertime(3);
  self.health_overlay.alpha = 0;

  while(gettime() < var_1) {
    if(self.health <= 0) {
      return;
    }
    if(isDefined(self.disable_breathing_sound) && self.disable_breathing_sound) {
      continue;
    }
    if(isDefined(level.gameskill_breath_func))
      [[level.gameskill_breath_func]]("breathing_hurt");
    else
      self playlocalsound("breathing_hurt");

    var_2 = 0.1;
    wait(var_2 + randomfloat(0.8));
  }
}

meleegrab_common() {
  self.hackable = 0;
  self.melee.inprogress = 1;

  if(isDefined(anim)) {
    if(isPlayer(self.melee.target))
      anim.meleechargeplayertimers[self.unittype] = gettime() + anim.meleechargeplayerintervals[self.unittype];
    else
      anim.meleechargetimers[self.unittype] = gettime() + anim.meleechargeintervals[self.unittype];
  }
}

meleegrab_counterinput(var_0) {
  level.player endon("meleegrab_interupt");
  level.player endon("bt_stop_meleegrab");
  var_1 = 0.5;
  var_2 = gettime();
  var_3 = var_0 - var_1;
  var_4 = var_2 + var_3 * 1000;
  var_5 = var_0;
  var_6 = var_2 + var_5 * 1000;
  thread meleegrab_slowmo(var_3, var_5);
  thread meleegrab_counterhint(var_3, var_1);

  while(playercounterpress())
    wait 0.05;

  for(;;) {
    var_2 = gettime();

    if(var_2 >= var_6) {
      break;
    }

    if(playercounterpress()) {
      if(var_2 > var_4 && var_2 < var_6) {
        if(isDefined(self.melee.meleecounterhint))
          level.player thread counterhintdestroy(0.1);

        self.melee.countersuccess = 1;
        level.player notify("bt_meleegrab_slowmo");
        return;
      }
    }

    wait 0.05;
  }

  level.player notify("bt_meleegrab_slowmo");
}

meleegrab_slowmo(var_0, var_1) {
  level.player endon("meleegrab_interupt");
  wait(var_0);
  setslowmotion(1, 0.3, 0.1);

  if(!isDefined(self.melee.countersuccess))
    level.player waittill("bt_meleegrab_slowmo");
  else
    wait 0.05;

  setslowmotion(0.2, 1, 0.05);
}

playercounterpress() {
  return isalive(level.player) && level.player meleeButtonPressed();
}

meleegrab_counterhint(var_0, var_1) {
  level.player endon("meleegrab_interupt");
  var_2 = 0.2;
  var_3 = 0.3;
  wait(var_0 - var_2 - 0.05);

  if(isDefined(self.melee.meleecounterhint))
    self.melee.meleecounterhint destroy();

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
  self.melee.meleecounterhint fadeovertime(var_2);
  self.melee.meleecounterhint changefontscaleovertime(var_2);
  self.melee.meleecounterhint.fontscale = 1.3;
  self.melee.meleecounterhint.alpha = 1;
  wait(var_2);

  if(!isDefined(self.melee.meleecounterhint)) {
    return;
  }
  self.melee.meleecounterhint fadeovertime(var_3);
  self.melee.meleecounterhint changefontscaleovertime(var_3);
  self.melee.meleecounterhint.fontscale = 1.2;
}

meleeset(var_0, var_1, var_2) {
  return isDefined(level.player.melee.countersuccess);
}

meleecountered(var_0, var_1, var_2) {
  return isDefined(level.player.melee.countersuccess) && level.player.melee.countersuccess;
}

meleecounteredfailed(var_0, var_1, var_2) {
  return isDefined(level.player.melee.countersuccess) && !level.player.melee.countersuccess;
}

counterhintdestroy(var_0) {
  if(isDefined(var_0)) {
    level.player.melee.meleecounterhint fadeovertime(var_0);
    level.player.melee.meleecounterhint changefontscaleovertime(var_0);
    level.player.melee.meleecounterhint.fontscale = 2;
    level.player.melee.meleecounterhint.alpha = 0;
    wait(var_0);
  }

  if(isDefined(level.player.melee) && isDefined(level.player.melee.meleecounterhint))
    level.player.melee.meleecounterhint destroy();
}