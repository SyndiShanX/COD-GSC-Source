/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\equipment\decoy_grenade.gsc
**************************************************/



#using script_16ea1b94f0f381b3;
#using scripts\common\utility;
#using scripts\cp\agent_damage;
#using scripts\cp\events;
#using scripts\cp\points;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace decoy_grenade;

function decoy_init() {
  leveldata = spawnStruct();
  level.decoygrenadedata = leveldata;
  leveldata.firetypes = [];
  leveldata.firetypeweights = [];
  leveldata.firetimes = [];
  leveldata.firemaxcounts = [];
  leveldata.fireintervalmintimes = [];
  leveldata.fireintervalmaxtimes = [];
  leveldata.fireminupimpulse = [];
  leveldata.firemaxupimpulse = [];
  leveldata.fireminforwardimpulse = [];
  leveldata.firemaxforwardimpulse = [];
  leveldata.firetypes[leveldata.firetypes.size] = "ar";
  leveldata.firetypeweights["ar"] = 35;
  leveldata.firetimes["ar"] = 0.4;
  leveldata.firemaxcounts["ar"] = 0;
  leveldata.fireintervalmintimes["ar"] = 0.5;
  leveldata.fireintervalmaxtimes["ar"] = 2;
  leveldata.fireminupimpulse["ar"] = 175;
  leveldata.firemaxupimpulse["ar"] = 225;
  leveldata.fireminforwardimpulse["ar"] = 55;
  leveldata.firemaxforwardimpulse["ar"] = 125;
  leveldata.firetypes[leveldata.firetypes.size] = "smg";
  leveldata.firetypeweights["smg"] = 50;
  leveldata.firetimes["smg"] = 0.4;
  leveldata.firemaxcounts["smg"] = 0;
  leveldata.fireintervalmintimes["smg"] = 0.25;
  leveldata.fireintervalmaxtimes["smg"] = 1;
  leveldata.fireminupimpulse["smg"] = 80;
  leveldata.firemaxupimpulse["smg"] = 125;
  leveldata.fireminforwardimpulse["smg"] = 175;
  leveldata.firemaxforwardimpulse["smg"] = 265;
  leveldata.firetypes[leveldata.firetypes.size] = "sniper";
  leveldata.firetypeweights["sniper"] = 15;
  leveldata.firetimes["sniper"] = 0.4;
  leveldata.firemaxcounts["sniper"] = 0;
  leveldata.fireintervalmintimes["sniper"] = 1;
  leveldata.fireintervalmaxtimes["sniper"] = 3;
  leveldata.fireminupimpulse["sniper"] = 250;
  leveldata.firemaxupimpulse["sniper"] = 375;
  leveldata.fireminforwardimpulse["sniper"] = 0;
  leveldata.firemaxforwardimpulse["sniper"] = 60;

  if(!threatbiasgroupexists("axis")) {
    createthreatbiasgroup("axis");
  }

  createthreatbiasgroup("decoy_grenade");
  createthreatbiasgroup("decoy_grenade_ignore");
  setignoremegroup("decoy_grenade", "decoy_grenade_ignore");
}

function decoy_used(grenade) {
  grenade endon("death");
  grenade.grenade_owner_name = self.name;
  grenade.playersdebuffed = [];
  grenade.decoyassists = 0;
  grenade allow_emp(0);
  function_641996b5e113c5c6(grenade, &decoy_empapplied);
  thread scripts\cp\weapon::monitordisownedgrenade(self, grenade);
  wait 0.4;
  grenade allow_emp(1);
  grenade thread scripts\cp\weapon::monitordamage(19, "hitequip", &decoy_handlefataldamage, &decoy_handledamage);
  grenade thread decoy_monitorposition();
  wait 0.6;
  endtime = gettime() + 5 * 1000;
  var_5db609b6270b36f5 = gettime();
  var_edaa2169ec420478 = 3;

  while(gettime() < endtime) {
    if(gettime() >= var_5db609b6270b36f5) {
      var_5db609b6270b36f5 = gettime() + 200;

      if(grenade decoy_isonground()) {
        var_edaa2169ec420478--;

        if(var_edaa2169ec420478 == 0) {
          break;
        }
      } else {
        var_edaa2169ec420478 = 3;
      }
    }

    wait 0.2;
  }

  grenade thread decoy_monitorfuse();
  grenade thread decoy_activated();
}

function decoy_activated() {
  self endon("death");
  self setotherent(self.owner);
  self setscriptablepartstate("beacon", "active", 0);
  firetype = decoy_getfiretype();

  while(true) {
    decoy_firesequence(firetype);
    wait randomfloatrange(0.5, 1.5);
  }
}

function decoy_destroy() {
  self setscriptablepartstate("destroy", "active", 0);
  self setscriptablepartstate("beacon", "neutral", 0);
  thread decoy_delete(0.1);
}

function decoy_delete(delay) {
  if(!isDefined(delay)) {
    delay = 0;
  }

  self notify("death");
  self.exploding = 1;
  function_83cebe0ae5318a7f(self);
  wait delay;
  self delete();
}

function decoy_firesequence(firetype) {
  leveldata = decoy_getleveldata();
  firecount = 1;

  if(leveldata.firemaxcounts[firetype] > 0) {
    firecount += randomint(leveldata.firemaxcounts[firetype]);
  }

  while(true) {
    firecount--;
    decoy_fireevent(firetype);

    if(firecount == 0) {
      break;
    }

    wait randomfloatrange(leveldata.fireintervalmintimes[firetype], leveldata.fireintervalmaxtimes[firetype]);
  }
}

function decoy_fireevent(firetype) {
  velocity = decoy_getvelocity();
  angles = decoy_getfireeventangles(velocity);
  impulse = decoy_getfireeventimpulse(velocity, firetype, angles);
  heldoffhand = self.owner getheldoffhand();

  if(!isDefined(heldoffhand) || heldoffhand.basename != "frag_grenade_mp") {
    self.owner scripts\cp\utility::_launchgrenade("decoy_grenade_mp", self.origin, impulse, 100, 1, self);
  }

  self setCanDamage(1);
  self setscriptablepartstate("beacon", "active", 0);
  self setscriptablepartstate("weaponFire", firetype + "Fire", 0);
  self setscriptablepartstate("weaponSounds", firetype + "Fire", 0);
  pinglocationenemyteams(self.origin, self.team, self.owner);
  scripts\cp\utility::make_entity_sentient_cp(self.team);
  self setthreatbiasgroup("decoy_grenade");
  decoy_debuffenemiesinrange(1);
  leveldata = decoy_getleveldata();
  wait leveldata.firetimes[firetype];
}

function decoy_debuffenemiesinrange(var_fce8828abf8327b) {
  var_16b6286d1893c20d = utility::function_98a826b6b6d0d118(self.origin, 800);

  foreach(enemy in var_16b6286d1893c20d) {
    if(!enemy scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, enemy))) {
      continue;
    }

    if(istrue(var_fce8828abf8327b) && isagent(enemy)) {
      enemy aieventlistenerevent("gunshot", self, self.origin);
      continue;
    }

    enemy aieventlistenerevent("decoy_grenade", self, self.origin);
  }
}

function decoy_aiseenplayerrecently(ai) {
  var_934f2bd9f0e5c04b = 1.5;

  for(i = 0; i < level.players.size; i++) {
    if(ai seerecently(level.players[i], var_934f2bd9f0e5c04b)) {
      return true;
    }
  }

  return false;
}

function decoy_aicanseeanyplayer(ai) {
  foreach(player in level.players) {
    if(decoy_canseeplayer(ai, player)) {
      return true;
    }
  }

  return false;
}

function decoy_canseeplayer(ai, player) {
  can_see = ai cansee(player);

  if(can_see) {
    passed = sighttracepassed(ai getEye(), player getEye(), 0, ai, 1);

    if(!passed) {
      return false;
    }

    contents = scripts\engine\trace::create_solid_ai_contents(1);

    if(!scripts\engine\trace::ray_trace_passed(ai getEye(), player getEye(), ai, contents)) {
      return false;
    }

    return true;
  }

  return false;
}

function decoy_ignoredbyenemy(ai) {
  ai setthreatbiasgroup("decoy_grenade_ignore");

  print3d(ai.origin, "<dev string:x1c>", (1, 1, 0), 1, 1, 50, 1);
}

function decoy_clearaithreatbiasgroup(ai) {
  group = ai getthreatbiasgroup();

  if(group == "decoy_grenade_ignore") {
    ai setthreatbiasgroup("axis");
  }
}

function decoy_debuffenemy(ai) {
  level endon("game_ended");
  self endon("death");
  owner = self.owner;
  owner endon("disconnect");
  self notify("decoy_debuffEnemy_" + ai getentitynumber());
  self endon("decoy_debuffEnemy_" + ai getentitynumber());
  self endon("decoy_stopTracking_" + ai getentitynumber());

  if(!isDefined(self.playersdebuffed[ai getentitynumber()])) {
    self.playersdebuffed[ai getentitynumber()] = ai;
    level thread decoy_delaystoptrackingassist(self, ai, 10);
    decoy_clearaithreatbiasgroup(ai);

    print3d(ai.origin, "<dev string:x29>", (1, 0, 0), 1, 1, 75, 1);
  }

  result = "";
  ai waittill("death");
  waitframe();

  if(isDefined(self)) {
    self.playersdebuffed[ai getentitynumber()] = undefined;
  }

  if(isDefined(ai.attackers)) {
    foreach(attacker in ai.attackers) {
      decoy_giveassistpoint(attacker, ai, owner);
    }

    return;
  }

  if(isDefined(ai.attacker)) {
    decoy_giveassistpoint(ai.attacker, ai, owner);
  }
}

function decoy_delaystoptrackingassist(grenade, ai, delay) {
  level endon("game_ended");
  ai endon("death");
  grenade endon("death");
  ai.baitedbydecoy = grenade;
  wait delay;
  grenade notify("decoy_stopTracking_" + ai getentitynumber());
}

function decoy_giveassistpoint(player, ai, owner) {
  if(!isDefined(scripts\cp\agent_damage::_validateattacker(player))) {
    return;
  }

  if(player == owner) {
    return;
  }

  ai_team = ai.team;

  if(!isDefined(ai.team) && isDefined(ai.agentteam)) {
    ai_team = ai.agentteam;
  }

  if(isDefined(ai_team) && isDefined(owner.team) && ai_team != owner.team) {
    if(self.decoyassists < 3) {
      owner thread scripts\cp\points::doscoreevent(#"assist_decoy");
      owner thread scripts\cp\events::killeventtextpopup(#"assist_decoy");
      self.decoyassists++;
    }
  }
}

function decoy_monitorposition() {
  self endon("death");

  while(true) {
    oldposition = self.origin;
    waitframe();
    self.oldposition = oldposition;
  }
}

function decoy_monitorfuse() {
  self endon("death");
  wait 7;
  thread decoy_destroy();
}

function decoy_empapplied(empstruct) {
  empstruct.victim decoy_givepointsfordestroy(empstruct.attacker);
  empstruct.victim thread decoy_destroy();
}

function decoy_handledamage(data) {
  return data.damage;
}

function decoy_handlefataldamage(data) {
  decoy_givepointsfordestroy(data.attacker);
  thread decoy_destroy();
}

function decoy_getfiretype() {
  dvarfiretype = getDvar(@ "hash_621c6f1da92a54d5", "<dev string:x30>");

  if(dvarfiretype != "<dev string:x30>") {
    return dvarfiretype;
  }

  totalweightvalue = 0;
  maxweightvalues = [];
  leveldata = decoy_getleveldata();

  for(i = 0; i < leveldata.firetypes.size; i++) {
    firetype = leveldata.firetypes[i];
    totalweightvalue += leveldata.firetypeweights[firetype];
    maxweightvalues[i] = totalweightvalue;
  }

  weightvalue = randomint(totalweightvalue);

  for(i = 0; i < maxweightvalues.size; i++) {
    if(weightvalue < maxweightvalues[i]) {
      return leveldata.firetypes[i];
    }
  }

  return undefined;
}

function decoy_getvelocity() {
  if(!isDefined(self.oldposition)) {
    return undefined;
  }

  return (self.origin - self.oldposition) / level.framedurationseconds;
}

function decoy_getfireeventangles(velocity) {
  angles = undefined;

  if(!isDefined(velocity)) {
    angles = (0, randomint(360), 0);
  } else if(velocity * (1, 1, 0) == (0, 0, 0)) {
    angles = (0, randomint(360), 0);
  } else if(randomint(100) < 20) {
    angles = (0, randomint(360), 0);
  } else {
    angles = vectortoangles(velocity * (1, 1, 0));
    yaw = angleclamp180(angles[1]);
    yaw += angleclamp(-30 + randomint(61));
    angles = (angles[0], yaw, angles[2]);
  }

  return angles;
}

function decoy_getfireeventimpulse(velocity, firetype, fireangles) {
  leveldata = decoy_getleveldata();
  impulse = velocity;
  impulse += anglestoup(fireangles) * randomfloatrange(leveldata.fireminupimpulse[firetype], leveldata.firemaxupimpulse[firetype]);
  impulse += anglesToForward(fireangles) * randomfloatrange(leveldata.fireminforwardimpulse[firetype], leveldata.firemaxforwardimpulse[firetype]);
  return impulse;
}

function decoy_isonground() {
  vel = decoy_getvelocity();

  if(!isDefined(vel) || abs(vel[2]) <= 200) {
    if(decoy_isongroundraycastonly()) {
      return true;
    }
  }

  return false;
}

function decoy_isongroundraycastonly() {
  contents = scripts\engine\trace::create_contents(0, 1, 0, 0, 1, 1);
  caststart = self.origin + (0, 0, 1);
  castend = caststart + (0, 0, -1) * 5;
  castresults = physics_raycast(caststart, castend, contents, self, 0, "physicsquery_closest", 1);

  if(isDefined(castresults) && castresults.size > 0) {
    return true;
  }

  return false;
}

function decoy_givepointsfordestroy(attacker) {
  if(isDefined(attacker) && istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
  }
}

function decoy_getleveldata() {
  return level.decoygrenadedata;
}

function function_3576a1db2837369e(color) {
  self endon("<dev string:x31>");

  while(true) {
    thread scripts\cp\utility::drawsphere(self.origin, 2, level.framedurationseconds, color);
    wait level.framedurationseconds;
  }
}

function function_2e44aa26dbb0cd3c() {
  self endon("<dev string:x31>");

  while(true) {
    vel = decoy_getvelocity();

    if(isDefined(vel)) {
      speed = length(vel);

      if(speed != 0) {
        velnorm = vel / speed;
        speed = clamp(speed, 0, 350);
        lineratio = speed / 350;
        thread scripts\cp\utility::drawline(self.origin, self.origin + velnorm * lineratio * 25, level.framedurationseconds, (0, 0, 1));
      }
    }

    wait level.framedurationseconds;
  }
}

# /