/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: abilities\gadgets\gadget_tripwire.gsc
*************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\damage;
#include scripts\core_common\damagefeedback_shared;
#include scripts\core_common\globallogic\globallogic_score;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\weapons_shared;
#include scripts\weapons\weaponobjects;

#namespace gadget_tripwire;

autoexec __init__system__() {
  system::register(#"gadget_tripwire", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("missile", "tripwire_state", 1, 2, "int");
  clientfield::register("scriptmover", "tripwire_solo_beam_fx", 1, 1, "int");
  callback::on_connect(&function_d863663f);
  weaponobjects::function_e6400478(#"eq_tripwire", &function_9f97e1a3, 1);
  level.tripwireweapon = getweapon("eq_tripwire");

  if(getgametypesetting(#"competitivesettings") === 1) {
    level.var_c72e8c51 = getscriptbundle("tripwire_custom_settings_comp");
  } else if(isDefined(level.tripwireweapon.customsettings)) {
    level.var_c72e8c51 = getscriptbundle(level.tripwireweapon.customsettings);
  } else {
    level.var_c72e8c51 = getscriptbundle("tripwire_custom_settings");
  }

  if(!isDefined(level.tripwires)) {
    level.tripwires = [];
  }

  if(!isDefined(level.var_5f6cceae)) {
    level.var_5f6cceae = [];
  }

  level.var_2e06b76a = &function_9e546fb3;
  callback::on_finalize_initialization(&function_3675de8b);
}

function_3675de8b() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon("eq_tripwire"), &function_bff5c062);
  }

  if(isDefined(level.var_a5dacbea)) {
    [[level.var_a5dacbea]](getweapon("eq_tripwire"), &weaponobjects::function_127fb8f3);
  }
}

function_bff5c062(tripwire, attackingplayer) {
  if(!isDefined(tripwire) || !isDefined(tripwire.watcher)) {
    return;
  }

  tripwire.owner weaponobjects::hackerremoveweapon(tripwire);
  tripwire notify(#"hacked");
  tripwire.owner = attackingplayer;
  tripwire setowner(attackingplayer);
  tripwire setteam(attackingplayer getteam());

  if(isDefined(tripwire.hacked)) {
    tripwire clientfield::set("tripwire_state", 3);
    tripwire.hacked = undefined;
  } else {
    tripwire clientfield::set("tripwire_state", 2);
    tripwire.hacked = 1;
  }

  if(isDefined(tripwire.entityenemyinfluencer)) {
    tripwire influencers::remove_influencer(tripwire.entityenemyinfluencer);
  }

  tripwire.entityenemyinfluencer = tripwire influencers::create_entity_enemy_influencer("claymore", attackingplayer.team);
  tripwire thread weaponobjects::function_6d8aa6a0(attackingplayer, tripwire.watcher);
  level function_d77f9442();
}

function_d863663f() {}

function_9f97e1a3(watcher) {
  watcher.watchforfire = 1;
  watcher.ondetonatecallback = &function_9e546fb3;
  watcher.ownergetsassist = 1;
  watcher.ignoredirection = 1;
  watcher.immediatedetonation = 0;
  watcher.onspawn = &on_tripwire_spawn;
  watcher.ondamage = &function_7a905654;
  watcher.ondestroyed = &function_9b3a657f;
  watcher.var_994b472b = &function_9a98f669;
  watcher.deleteonplayerspawn = 0;
  watcher.activatesound = #"hash_3185e3ad37d8b947";
  watcher.ontimeout = &function_9b3a657f;
  watcher.onfizzleout = &function_9b3a657f;
}

function_ec88b3b9(pos) {
  newx = pos[0] - int(pos[0]) >= 0.5 ? ceil(pos[0]) : floor(pos[0]);
  newy = pos[1] - int(pos[1]) >= 0.5 ? ceil(pos[1]) : floor(pos[1]);
  newz = pos[2] - int(pos[2]) >= 0.5 ? ceil(pos[2]) : floor(pos[2]);
  pos = (newx, newy, newz);
  return pos;
}

function_9366bdf9(tripwire, owner) {
  if(!isDefined(level.var_ac6052e9)) {
    return;
  }

  enemyplayers = owner getenemiesinradius(tripwire.origin, [[level.var_ac6052e9]]("tripwireThreatRadius", 500));

  foreach(enemy in enemyplayers) {
    if(!isplayer(enemy)) {
      continue;
    }

    enemyeye = enemy geteyeapprox();

    if(!sighttracepassed(enemyeye, tripwire.origin, 0, enemy)) {
      continue;
    }

    if(isDefined(level.var_ddfd70d)) {
      enemy[[level.var_ddfd70d]](getweapon("eq_tripwire"), 0);
      return;
    }
  }
}

on_tripwire_spawn(watcher, player) {
  player endon(#"disconnect");
  level endon(#"game_ended");
  self endon(#"death");
  weaponobjects::onspawnuseweaponobject(watcher, player);
  self.var_2d045452 = watcher;
  self.weapon = level.tripwireweapon;
  self setweapon(level.tripwireweapon);
  waitresult = self waittill(#"stationary");
  self util::make_sentient();
  self.hitnormal = waitresult.normal;
  self.origin = function_ec88b3b9(waitresult.position);
  killcament = spawn("script_model", self.origin + self.hitnormal * 5);
  killcament.targetname = "gadget_tripwire_killcament";
  self.killcament = killcament;

  if(isDefined(waitresult.target) && (isvehicle(waitresult.target) || waitresult.target ismovingplatform() || waitresult.target.dynamicent === 1)) {
    self thread function_15566346(waitresult.target);
  }

  self.var_db7f2def = self gettagorigin("tag_fx") + self.hitnormal * 2;
  self.owner = player;
  self.team = player.team;
  self.watcher = watcher;
  self clientfield::set("friendlyequip", 1);
  self.entityenemyinfluencer = self influencers::create_entity_enemy_influencer("claymore", player.team);
  self.destroyablebytrophysystem = 0;
  self.detonating = 0;
  wait level.var_c72e8c51.var_e14f5fca;
  player notify(#"tripwire_spawn", {
    #tripwire: self
  });
  self clientfield::set("tripwire_state", 1);
  arrayinsert(level.tripwires, self, level.tripwires.size);
  level function_d77f9442();
  function_9366bdf9(self, player);
  self thread function_15de8daf();
}

function_15566346(ent) {
  self endon(#"death");
  oldpos = ent.origin;

  while(true) {
    if(!isDefined(ent)) {
      return;
    }

    curpos = ent.origin;

    if(isDefined(curpos) && distancesquared(oldpos, curpos)) {
      self thread function_9e546fb3(undefined, self.weapon, undefined, undefined);
    }

    oldpos = curpos;
    wait float(function_60d95f53()) / 1000;
  }
}

function_d77f9442() {
  foreach(tripwire in level.tripwires) {
    if(!isDefined(tripwire)) {
      continue;
    }

    tripwire thread function_55c50f15();
  }

  foreach(tripwire in level.tripwires) {
    if(!isDefined(tripwire)) {
      continue;
    }

    if(tripwire.var_c2f0f6da) {
      tripwire thread function_6c66b650();
      continue;
    }

    if(!isDefined(tripwire.var_886bd8dc)) {
      tripwire function_b9549a9();
    } else {
      tripwire function_684adc9();
    }

    tripwire.var_886bd8dc clientfield::set("tripwire_solo_beam_fx", 1);
  }
}

function_684adc9() {
  if(isDefined(self.owner)) {
    self.var_886bd8dc setowner(self.owner);
    self.var_886bd8dc setteam(self.owner.team);
    return;
  }

  self.var_886bd8dc setteam(self.team);
}

function_b9549a9() {
  self endon(#"death");
  angles = vectortoangles(self.hitnormal);
  pos = self gettagorigin("tag_fx");
  fxorg = spawn("script_model", pos, 0, angles);
  fxorg.targetname = "gadget_tripwire_fxorg";
  fxorg.angles = angles;
  fxorg setModel(#"tag_origin");
  self.var_886bd8dc = fxorg;
  fxorg linkto(self);

  if(!isDefined(self.activated)) {
    self playSound(#"hash_58a0696fb1726978");
    self playLoopSound(#"hash_3e09d676ac6291c1", 0.25);
    self.activated = 1;
  }

  self function_684adc9();
}

function_6c66b650() {
  if(isDefined(self.var_886bd8dc)) {
    self.var_886bd8dc clientfield::set("tripwire_solo_beam_fx", 0);
  }
}

function_a4b3da97(trace) {
  if(trace[#"fraction"] < 1) {
    return false;
  }

  return true;
}

function_55c50f15() {
  self endon(#"death");
  self.var_c2f0f6da = 0;
  self.var_5cbe5bde = [];

  foreach(tripwire in level.tripwires) {
    if(!isDefined(tripwire)) {
      continue;
    }

    if(self.owner != tripwire.owner) {
      continue;
    }

    if(self == tripwire) {
      continue;
    }

    if(distancesquared(tripwire.origin, self.origin) >= 100 && distancesquared(tripwire.origin, self.origin) <= level.var_c72e8c51.var_831055cb * level.var_c72e8c51.var_831055cb) {
      trace = beamtrace(tripwire.var_db7f2def, self.var_db7f2def, 0, self, 0, 0, tripwire);
      var_f2edf308 = beamtrace(self.var_db7f2def, tripwire.var_db7f2def, 0, self, 0, 0, tripwire);

      if(self function_a4b3da97(trace) && self function_a4b3da97(var_f2edf308)) {
        arrayinsert(self.var_5cbe5bde, tripwire, self.var_5cbe5bde.size);
        self.var_c2f0f6da = 1;

        if(!isDefined(self.activated)) {
          self playSound(#"hash_58a0696fb1726978");
          self playLoopSound(#"hash_3e09d676ac6291c1", 0.25);
          self.activated = 1;
        }
      }
    }
  }

  return self.var_c2f0f6da;
}

function_55e95173(hitent) {
  if(sessionmodeiswarzonegame()) {
    return false;
  }

  if(!isDefined(hitent)) {
    return false;
  }

  if(util::function_fbce7263(self.team, hitent.team)) {
    return false;
  }

  return true;
}

function_430b5b99(entity, tripmine) {
  if(sessionmodeiswarzonegame() && isDefined(self.var_c2f0f6da) && self.var_c2f0f6da && !isDefined(entity)) {
    return true;
  }

  if(!isDefined(entity)) {
    return false;
  }

  if(!util::function_fbce7263(entity.team, tripmine.team)) {
    return false;
  }

  if(!isplayer(entity) && !isvehicle(entity) && !isai(entity) && !entity ismovingplatform() && !(isDefined(entity.var_4f564337) && entity.var_4f564337)) {
    return false;
  }

  if(isvehicle(entity)) {
    if(entity isremotecontrol()) {
      owner = entity getvehicleowner();

      if(!isDefined(owner)) {
        return false;
      }
    } else {
      owner = entity getseatoccupant(0);
    }

    if(isplayer(owner) && !util::function_fbce7263(owner.team, tripmine.team)) {
      return false;
    }
  }

  if(isplayer(entity) && entity hasperk(#"specialty_nottargetedbytripwire")) {
    return false;
  }

  if(isplayer(entity) && entity isjuking()) {
    return false;
  }

  return true;
}

function_5b8dea90(player) {
  if(!player isgrappling()) {
    return false;
  }

  if(!util::function_fbce7263(player.team, self.team)) {
    return false;
  }

  if(player hasperk(#"specialty_nottargetedbytripwire")) {
    return false;
  }

  if(distancesquared(player.origin, player.prev_origin) == 0) {
    return false;
  }

  return true;
}

function_d334c3fa(endpoint) {
  self endon(#"death");

  if(!isDefined(self.owner)) {
    return 0;
  }

  result = 0;
  enemyplayers = getplayers("all", self.origin, level.var_c72e8c51.var_831055cb);

  foreach(player in enemyplayers) {
    if(!isDefined(player.prev_origin)) {
      player.prev_origin = player.origin;
    }

    if(!function_5b8dea90(player)) {
      player.prev_origin = player.origin;
      continue;
    }

    points = math::function_f16fbd66(self.var_db7f2def, endpoint, player.origin, player.prev_origin, 1);

    if(!isDefined(points)) {
      return 0;
    }

    mins = player getmins() + points.pointb;
    maxs = player getmaxs() + points.pointb;
    result = function_fc3f770b(mins, maxs, points.pointa);

    if(result) {
      return result;
    }

    player.prev_origin = player.origin;
  }

  return result;
}

function_15de8daf() {
  self endoncallback(&function_84101bb5, #"death");
  self.var_d33355ff = [];

  while(true) {
    if(self.var_c2f0f6da) {
      foreach(tripwire in self.var_5cbe5bde) {
        if(!isDefined(tripwire)) {
          continue;
        }

        if(self.var_d33355ff.size > 0 && isinarray(self.var_d33355ff, tripwire)) {
          continue;
        }

        if(!self.detonating && !tripwire.detonating) {
          dotrace = 1;

          if(function_d334c3fa(tripwire.var_db7f2def)) {
            self thread function_9e546fb3(undefined, self.weapon, undefined, tripwire);
            dotrace = 0;
            break;
          }

          if(dotrace) {
            tripwire.var_d33355ff[tripwire.var_d33355ff.size] = self;
            trace = beamtrace(tripwire.var_db7f2def, self.var_db7f2def, 1, self, 0, 0, tripwire, 1);

            if(trace[#"fraction"] < 0.99) {
              if(function_430b5b99(trace[#"entity"], self)) {
                level notify(#"tripwire_detonation", {
                  #entity: trace[#"entity"]
                });
                self thread function_9e546fb3(undefined, self.weapon, undefined, tripwire, trace[#"entity"]);
              }

              if(function_55e95173(trace[#"entity"])) {
                trace = beamtrace(self.var_db7f2def, tripwire.var_db7f2def, 1, self, 0, 0, tripwire, 1);

                if(trace[#"fraction"] < 0.99) {
                  if(function_430b5b99(trace[#"entity"], self)) {
                    level notify(#"tripwire_detonation", {
                      #entity: trace[#"entity"]
                    });
                    self thread function_9e546fb3(undefined, self.weapon, undefined, tripwire, trace[#"entity"]);
                  }
                }
              }
            }
          }
        }
      }

      self.var_d33355ff = [];
    } else if(self.detonating == 0) {
      endpos = self.var_db7f2def + self.hitnormal * level.var_c72e8c51.var_9e266f9b;
      dotrace = 1;

      if(function_d334c3fa(endpos)) {
        self thread function_9e546fb3(undefined, self.weapon, undefined, undefined);
        dotrace = 0;
        break;
      }

      if(dotrace) {
        trace = beamtrace(self.var_db7f2def - self.hitnormal * 5, endpos, 1, self);

        if(trace[#"fraction"] < 0.95) {
          if(function_430b5b99(trace[#"entity"], self)) {
            self thread function_9e546fb3(undefined, self.weapon, undefined, undefined);
          }
        }
      }
    }

    waitframe(2);
  }
}

private function_84101bb5(notifyhash) {
  beamfx = self.var_886bd8dc;
  killcament = self.killcament;
  self.var_886bd8dc = undefined;
  self.killcament = undefined;
  waitframe(1);

  if(isDefined(beamfx)) {
    beamfx clientfield::set("tripwire_solo_beam_fx", 0);
    util::wait_network_frame();

    if(isDefined(beamfx)) {
      beamfx delete();
    }
  }

  if(isDefined(killcament)) {
    killcament delete();
  }
}

function_9e546fb3(attacker, weapon, target, var_2f6adbe3, tripper) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");

  if(isDefined(attacker)) {
    if(self.owner util::isenemyplayer(attacker)) {
      self.owner globallogic_score::function_5829abe3(attacker, weapon, self.weapon);
    }

    self radiusdamage(self.origin, 55, 10, 10, self.owner, "MOD_UNKNOWN");

    if(isDefined(level.var_d2600afc)) {
      self[[level.var_d2600afc]](attacker, self.owner, self.weapon, weapon);
    }

    self thread function_9b3a657f(weapon);
  } else {
    self playSound(#"hash_1f0de5f27d29d3aa");
    self.detonating = 1;

    if(isDefined(var_2f6adbe3)) {
      var_2f6adbe3.detonating = 1;
    }

    wait level.var_c72e8c51.var_7f1fc1ee;

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(var_2f6adbe3)) {
      explosiondist = isDefined(level.var_c72e8c51.var_e44a7667) ? level.var_c72e8c51.var_e44a7667 : 0;
      nearradius = isDefined(level.var_c72e8c51.var_b1f240d7) ? level.var_c72e8c51.var_b1f240d7 : 0;
      farradius = isDefined(level.var_c72e8c51.var_d484364c) ? level.var_c72e8c51.var_d484364c : 0;
      maxdamage = isDefined(level.var_c72e8c51.var_89d80d88) ? level.var_c72e8c51.var_89d80d88 : 0;
      mindamage = isDefined(level.var_c72e8c51.var_cd9b7eaf) ? level.var_c72e8c51.var_cd9b7eaf : 0;
    } else {
      explosiondist = isDefined(level.var_c72e8c51.var_13e9ceba) ? level.var_c72e8c51.var_13e9ceba : 0;
      nearradius = isDefined(level.var_c72e8c51.var_d0a598a5) ? level.var_c72e8c51.var_d0a598a5 : 0;
      farradius = isDefined(level.var_c72e8c51.var_fcb3348e) ? level.var_c72e8c51.var_fcb3348e : 0;
      maxdamage = isDefined(level.var_c72e8c51.var_aebac5e5) ? level.var_c72e8c51.var_aebac5e5 : 0;
      mindamage = isDefined(level.var_c72e8c51.var_69bf01c2) ? level.var_c72e8c51.var_69bf01c2 : 0;
    }

    explosiondir = self.hitnormal;
    explosionsound = #"exp_tripwire";

    if(isDefined(var_2f6adbe3)) {
      explosionsound = #"exp_tripwire";
      explosiondir = self.origin - var_2f6adbe3.origin;
      explosiondir = vectornormalize(explosiondir);
      perpvec = perpendicularvector(explosiondir);
      owner = isDefined(var_2f6adbe3.owner) && isentity(var_2f6adbe3.owner) ? var_2f6adbe3.owner : undefined;
      var_2f6adbe3 cylinderdamage(explosiondir * explosiondist, var_2f6adbe3.origin, nearradius, farradius, maxdamage, mindamage, owner, "MOD_EXPLOSIVE", self.weapon);
      playFX(#"hash_69455dfeef0311c2", var_2f6adbe3.origin, explosiondir, perpvec);
      playsoundatposition(explosionsound, self.origin);
      playsoundatposition(explosionsound, var_2f6adbe3.origin);
      var_2f6adbe3 ghost();
      explosiondir = var_2f6adbe3.origin - self.origin;
      explosiondir = vectornormalize(explosiondir);
    }

    if(isDefined(self) && isDefined(self.owner)) {
      if(!isDefined(explosiondir)) {
        ang = self.angles;

        if(isDefined(ang)) {
          explosiondir = anglesToForward(ang);
        } else {
          explosiondir = (1, 0, 0);
        }
      }

      perpvec = perpendicularvector(explosiondir);
      playFX(#"hash_69455dfeef0311c2", self.origin, explosiondir, perpvec);
      self playSound(explosionsound);

      if(!isDefined(self.hitnormal)) {
        self.hitnormal = (0, 0, 1);
      }

      if(isDefined(tripper) && isvehicle(tripper)) {
        if(isDefined(var_2f6adbe3)) {
          maxdamage *= 1.5;
          mindamage *= 1.5;
        }

        self radiusdamage(self.origin + self.hitnormal * 5, explosiondist * 0.75, maxdamage, mindamage, self.owner, "MOD_EXPLOSIVE", self.weapon);
      } else if(!isDefined(var_2f6adbe3)) {
        self radiusdamage(self.origin + self.hitnormal * 5, explosiondist / 2, maxdamage, mindamage, self.owner, "MOD_EXPLOSIVE", self.weapon);
      } else {
        self cylinderdamage(explosiondir * explosiondist, self.origin, nearradius, farradius, maxdamage, mindamage, self.owner, "MOD_EXPLOSIVE", self.weapon);
      }
    }
  }

  self ghost();
  wait 0.1;

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var_2f6adbe3)) {
    arrayremovevalue(level.tripwires, var_2f6adbe3);

    if(isDefined(var_2f6adbe3.var_886bd8dc)) {
      var_2f6adbe3.var_886bd8dc clientfield::set("tripwire_solo_beam_fx", 0);
      util::wait_network_frame();

      if(isDefined(var_2f6adbe3) && isDefined(var_2f6adbe3.var_886bd8dc)) {
        var_2f6adbe3.var_886bd8dc delete();
        var_2f6adbe3.var_886bd8dc = undefined;
      }
    }

    if(isDefined(self.killcament)) {
      self.killcament delete();
      self.killcament = undefined;
    }

    if(isDefined(var_2f6adbe3)) {
      if(isDefined(var_2f6adbe3.killcament)) {
        var_2f6adbe3.killcament delete();
      }

      var_2f6adbe3 delete();
    }
  }

  self stoploopsound(0.5);
  arrayremovevalue(level.tripwires, self);

  if(isDefined(self.var_886bd8dc)) {
    self.var_886bd8dc clientfield::set("tripwire_solo_beam_fx", 0);
    util::wait_network_frame();

    if(!isDefined(self)) {
      return;
    }

    if(isDefined(self.var_886bd8dc)) {
      self.var_886bd8dc delete();
      self.var_886bd8dc = undefined;
    }
  }

  if(isDefined(self.killcament)) {
    self.killcament delete();
    self.killcament = undefined;
  }

  level thread function_d77f9442();
  self delete();
}

function_9a98f669(player) {
  self function_9b3a657f(undefined);
}

function_9b3a657f(weapon) {
  self clientfield::set("friendlyequip", 1);
  playFX(#"hash_65c5042becfbaa7d", self.origin);

  if(isDefined(level.var_c72e8c51.var_bb6c29b4) && isDefined(weapon) && weapon == getweapon(#"shock_rifle")) {
    playFX(level.var_c72e8c51.var_bb6c29b4, self.origin);
  }

  playsoundatposition(#"hash_5a530df2bd2b027c", self.origin);
  self stoploopsound(0.5);
  arrayremovevalue(level.tripwires, self);
  var_886bd8dc = self.var_886bd8dc;
  killcament = self.killcament;

  if(isDefined(var_886bd8dc)) {
    var_886bd8dc clientfield::set("tripwire_solo_beam_fx", 0);
    util::wait_network_frame();

    if(isDefined(var_886bd8dc)) {
      var_886bd8dc delete();

      if(isDefined(self)) {
        self.var_886bd8dc = undefined;
      }
    }
  }

  if(isDefined(killcament)) {
    killcament delete();

    if(isDefined(self)) {
      self.killcament = undefined;
    }
  }

  level thread function_d77f9442();

  if(isDefined(self)) {
    self delete();
  }
}

function_7a905654(watcher) {
  self endon(#"death");
  self setCanDamage(1);
  damagemax = 20;
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self.damagetaken = 0;
  attacker = undefined;

  while(true) {
    waitresult = self waittill(#"damage");
    attacker = waitresult.attacker;
    weapon = waitresult.weapon;
    damage = waitresult.amount;
    type = waitresult.mod;
    idflags = waitresult.flags;

    if(weapon == getweapon("eq_tripwire")) {
      continue;
    }

    damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);
    attacker = self[[level.figure_out_attacker]](waitresult.attacker);

    if(!isDefined(self.owner)) {
      continue;
    }

    if(level.teambased && isplayer(attacker)) {
      if(!(isDefined(level.hardcoremode) && level.hardcoremode) && !util::function_fbce7263(self.owner.team, attacker.pers[#"team"]) && self.owner !== attacker) {
        continue;
      }
    }

    if(watcher.stuntime > 0 && weapon.dostun) {
      self thread weaponobjects::stunstart(watcher, watcher.stuntime);
    }

    if(damage::friendlyfirecheck(self.owner, attacker)) {
      if(damagefeedback::dodamagefeedback(weapon, attacker)) {
        attacker damagefeedback::update();
      }
    }

    if(type == "MOD_MELEE" || weapon.isemp || weapon.destroysequipment) {
      self.damagetaken = damagemax;
    } else {
      self.damagetaken += damage;
    }

    if(self.damagetaken >= damagemax) {
      watcher thread weaponobjects::waitanddetonate(self, 0.05, attacker, weapon);
      return;
    }
  }
}