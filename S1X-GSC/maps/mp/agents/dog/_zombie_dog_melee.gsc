/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\dog\_zombie_dog_melee.gsc
****************************************************/

main() {
  self endon("death");
  self endon("killanimscript");
  self.curmeleetarget endon("disconnect");
  var_0 = distancesquared(self.curmeleetarget.origin, self.origin);
  var_1 = maps\mp\agents\humanoid\_humanoid::getmeleeattackpoint(self.curmeleetarget);

  if(maps\mp\agents\humanoid\_humanoid_melee::ismeleeblocked()) {
    return maps\mp\agents\humanoid\_humanoid_melee::meleefailed();
  }

  doattackstandard(self.curmeleetarget, var_1.origin);
}

end_script() {
  self scragentsetanimscale(1, 1);
}

getmeleeanimstate() {
  return "attack_run_and_jump";
}

doattackstandard(var_0, var_1) {
  var_2 = getmeleeanimstate();
  var_3 = self.nonmoveratescale;
  var_4 = 0;
  var_5 = 0;
  self.lastmeleefailedmypos = undefined;
  self.lastmeleefailedpos = undefined;
  var_6 = randomint(self getanimentrycount(var_2));
  var_7 = self getanimentry(var_2, var_6);
  var_8 = getanimlength(var_7);
  var_9 = getnotetracktimes(var_7, "dog_melee");
  var_10 = var_8 / var_3 * 0.33;

  if(var_9.size > 0) {
    var_10 = var_8 / var_3 * var_9[0];
  }

  self scragentsetphysicsmode("gravity");

  if(var_5) {
    self scragentsetorientmode("face enemy");
  } else {
    self scragentsetorientmode("face angle abs", (0, vectortoyaw(var_0.origin - self.origin), 0));
  }

  self scragentsetanimmode("anim deltas");
  maps\mp\agents\_scripted_agent_anim_util::set_anim_state(var_2, var_6, var_3);

  if(var_4) {
    self scragentsetanimscale(0, 1);
    self scragentdoanimlerp(self.origin, var_1, var_10);
    childthread updatelerppos(var_0, var_10, 1, self.lungelerprange);
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked(1, "DoAttackStandard");
  } else {
    self scragentsetanimscale(1, 1);
  }

  wait(var_10);
  self notify("cancel_updatelerppos");
  self scragentsetanimmode("anim deltas");
  self scragentsetanimscale(1, 1);

  if(var_4) {
    maps\mp\agents\_scripted_agent_anim_util::setstatelocked(0, "DoAttackStandard");
  }

  if(maps\mp\agents\humanoid\_humanoid_melee::attackshouldhit(var_0)) {
    self notify("attack_hit", var_0, var_1);
    var_11 = 0;

    if(isDefined(var_0)) {
      var_11 = var_0.health;
    }

    if(isDefined(self.meleedamage)) {
      var_11 = self.meleedamage;
    }

    if(isalive(var_0)) {
      maps\mp\agents\humanoid\_humanoid_melee::domeleedamage(var_0, var_11, "MOD_IMPACT");
    }
  } else {
    self notify("attack_miss", var_0, var_1);
  }

  self.lastmeleepos = self.origin;
  var_12 = var_8 / var_3 - var_10;

  if(var_12 > 0) {
    maps\mp\agents\_scripted_agent_anim_util::waituntilnotetrack_safe("attack_anim", "end", var_12);
  }

  self.lastmeleefinishtime = gettime();
}

updatelerppos(var_0, var_1, var_2) {
  self endon("killanimscript");
  self endon("death");
  self endon("cancel_updatelerppos");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_3 = var_1;
  var_4 = 0.05;

  for(;;) {
    wait(var_4);
    var_3 = var_3 - var_4;

    if(var_3 <= 0) {
      break;
    }

    var_5 = getupdatedattackpos(var_0, var_2);

    if(!isDefined(var_5)) {
      break;
    }

    self scragentdoanimlerp(self.origin, var_5, var_3);
  }
}

getupdatedattackpos(var_0, var_1) {
  if(!var_1) {
    var_2 = maps\mp\zombies\_util::droppostoground(var_0.origin);
    return var_2;
  } else {
    var_3 = var_0.origin - self.origin;
    var_4 = length(var_3);

    if(var_4 < self.attackoffset) {
      return self.origin;
    } else {
      var_3 = var_3 / var_4;
      var_5 = var_0.origin - var_3 * self.attackoffset;

      if(maps\mp\zombies\_util::canmovepointtopoint(self.origin, var_5)) {
        return var_5;
      } else {
        return undefined;
      }
    }
  }
}