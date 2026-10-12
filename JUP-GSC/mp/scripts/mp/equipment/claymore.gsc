/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\claymore.gsc
***********************************************/

#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\train_utility;
#using scripts\cp_mp\vehicles\vehicle_mines;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#using scripts\mp\equipment\claymore;
#using scripts\mp\equipment_interact;
#using scripts\mp\hud_message;
#using scripts\mp\killstreaks\killstreaks;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\equipment;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#using scripts\mp\weapons;
#namespace claymore;

function claymore_init() {
  level._effect["claymore_explode"] = loadfx("vfx/iw9/core/equipment/vfx_equip_claymore_trigger.vfx");

  if(istrue(game["isLaunchChunk"])) {
    return;
  }

  minetriggerdata = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataformine("equip_claymore", 1);
  minetriggerdata.triggercallback = &claymore_triggerfromvehicle;
}

function claymore_use(grenade) {
  self endon("death_or_disconnect");
  grenade endon("death");

  if(_hasperk("specialty_rugged_eqp")) {
    grenade.hasruggedeqp = 1;
  }

  grenade.exploding = 1;
  thread scripts\mp\weapons::monitordisownedgrenade(self, grenade);

  if(isDefined(scripts\cp_mp\utility\player_utility::getvehicle())) {
    scripts\mp\hud_message::showerrormessage(grenade.bundle.var_512d802771a9bd3f);
    thread scripts\mp\equipment::incrementequipmentammo("equip_claymore", 1);
    waitframe();
    grenade delete();
  }

  plantdata = spawnStruct();
  plantdata.throwspeedforward = 100;
  plantdata.throwspeedup = -50;
  plantdata.castdivisions = 3;
  plantdata.castmaxtime = 0.5;
  plantdata.castdetail = 1;
  plantdata.plantmaxtime = 0.5;
  plantdata.plantmaxroll = 15;
  plantdata.plantmindistbeloweye = 12;
  plantdata.plantmaxdistbelowownerfeet = 20;
  plantdata.plantmindisteyetofeet = 45;
  plantdata.plantnormalcos = 0.342;
  plantdata.plantoffsetz = 3;

  if(scripts\cp_mp\utility\train_utility::player_standing_on_train()) {
    plantdata.plantoffsetz += 2;
    plantdata.contents = scripts\cp_mp\utility\train_utility::function_d699841d5e241043();
  } else {
    plantdata.contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass"]);
  }

  plantresult = scripts\mp\utility\equipment::plant(grenade, plantdata);

  if(!istrue(plantresult)) {
    scripts\mp\hud_message::showerrormessage(grenade.bundle.var_512d802771a9bd3f);
    thread scripts\mp\equipment::incrementequipmentammo("equip_claymore", 1);
    grenade delete();
    return;
  }

  if(isDefined(level.var_ca4e08767cbdae12)) {
    canplant = grenade[[level.var_ca4e08767cbdae12]]();

    if(!canplant) {
      scripts\mp\hud_message::showerrormessage(grenade.bundle.var_512d802771a9bd3f);
      scripts\mp\equipment::incrementequipmentslotammo("primary");
      grenade delete();
      return;
    }
  }

  linkedparent = grenade getlinkedparent();

  if(isDefined(linkedparent)) {
    grenade explosivehandlemovers(linkedparent);
  }

  grenade.exploding = 0;
  grenade thread claymore_plant();

  if(scripts\engine\utility::issharedfuncdefined("entity", "trackEntityLimit")) {
    [[scripts\engine\utility::getsharedfunc("entity", "trackEntityLimit")]](grenade, self, "claymore");
    grenade thread function_a05a0b89582e22a3();
  }
}

function claymore_plant() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  owner = self.owner;
  team = self.owner.team;
  scripts\cp_mp\ent_manager::registerspawn(1, &sweepclaymore);
  scripts\mp\sentientpoolmanager::registersentient("Lethal_Static", owner, 1);
  thread makeexplosiveusabletag("tag_use", 1);
  owner onequipmentplanted(self, "equip_claymore", &claymore_delete);
  thread monitordisownedequipment(owner, self);
  self missilethermal();
  self missileoutline();
  self setentityowner(owner);
  self setotherent(owner);
  self setnodeploy(1);
  self.headiconid = scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 5, undefined, undefined, undefined, 0.1, 1);
  thread scripts\mp\weapons::outlineequipmentforowner(self);
  thread minedamagemonitor();
  thread claymore_explodeonnotify();

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    self[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_ac5843028846c67);
  }

  if(issharedfuncdefined("emp", "setEMP_Cleared_Callback")) {
    self[[getsharedfunc("emp", "setEMP_Cleared_Callback")]](&function_b3a55145aba7855e);
  }

  scripts\cp_mp\emp_debuff::set_apply_emp_callback(&claymore_empapplied);
  scripts\cp_mp\equipment\haywire::function_172d848d58051fdf(&function_4373872960a2d51a);
  function_49197cd063a740ea(&claymore_destroy);

  if(isDefined(level.elevators)) {
    foreach(elevators in level.elevators) {
      elevators thread scripts\common\elevators::isentitytouchingdoortrigger(self);
    }
  }

  claymore_updatedangerzone();
  self setscriptablepartstate("plant", "active", 0);
  owner setscriptablepartstate("equipClaymoreFXView", "plant", 0);
  thread claymore_forceclampangles();
  wait self.bundle.var_fc5fafaec60831f9;
  self setscriptablepartstate("arm", "active", 0);
  thread claymore_watchfortrigger();
  thread scripts\mp\equipment_interact::remoteinteractsetup(&claymore_trigger, 1, 1);
}

function claymore_updatedangerzone() {
  if(istrue(level.dangerzoneskipequipment)) {
    return;
  }

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
  }

  self.dangerzone = scripts\mp\spawnlogic::addspawndangerzone(self.origin, scripts\mp\spawnlogic::getdefaultminedangerzoneradiussize(), 72, self.owner.team, undefined, self.owner, 0, self, 1);
}

function claymore_forceclampangles() {
  self endon("mine_selfdestruct");
  self endon("death");
  endtime = gettime() + 2000;

  while(endtime > gettime()) {
    yawonly = (0, self.angles[1], 0);
    maxdiff = 15;
    self.angles = anglelerpquat(yawonly, self.angles, maxdiff);
    waitframe();
  }
}

function claymore_watchfortrigger() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");
  contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water"]);

  while(true) {
    self waittill("trigger_grenade", entarr);
    assert(isDefined(entarr));

    if(istrue(self.stunned)) {
      continue;
    }

    foreach(ent in entarr) {
      if(isDefined(ent.classname)) {
        if(ent.classname == "script_vehicle") {
          if(ent scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_isfriendlytomine(self)) {
            continue;
          }

          if(!scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_shouldvehicletriggermine(ent, self)) {
            continue;
          }

          scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_minetrigger(ent, self);
          break;
        }

        if(isagent(ent) || isPlayer(ent)) {
          if(!isreallyalive(ent)) {
            continue;
          }

          forward = anglesToForward(self.angles);
          up = anglestoup(self.angles);
          castorigin = self.origin + up * 0;

          if(isent(self)) {
            ignorelist = scripts\mp\utility\equipment::get_mine_ignore_list();
          } else {
            ignorelist = [];
          }

          var_ad283a45677a1ea3 = ent gettagorigin("j_mainroot");
          eorigins = [var_ad283a45677a1ea3];
          btwn = castorigin - var_ad283a45677a1ea3;
          eorigin = ent.origin;

          if(vectordot(btwn, (0, 0, 1)) >= 0) {
            eorigin = isDefined(ent gettagorigin("j_spineupper", 1)) ? ent gettagorigin("j_spineupper", 1) : eorigin;
          }

          eorigins[eorigins.size] = eorigin;
          handled = 0;

          foreach(eorigin in eorigins) {
            btwn = eorigin - self.origin;
            var_cc00b910bd1d69c8 = vectordot(btwn, forward);

            if(var_cc00b910bd1d69c8 > 90) {
              continue;
            }

            var_69211973f7d7bbd6 = vectordot(btwn, up);

            if(abs(var_69211973f7d7bbd6) > 32) {
              continue;
            }

            var_a3d051ef761efd24 = vectorNormalize(btwn);
            var_74876e67651c79a6 = vectordot(var_a3d051ef761efd24, forward);

            if(var_74876e67651c79a6 < 0.86602) {
              continue;
            }

            castresults = physics_raycast(castorigin, eorigin, contents, ignorelist, 0, "physicsquery_closest", 1);

            if(isDefined(castresults) && castresults.size > 0) {
              continue;
            }

            handled = 1;
            thread claymore_trigger(ent);
          }

          if(handled) {
            break;
          }
        }
      }
    }
  }
}

function claymore_trigger(ent, attacker) {
  self endon("mine_destroyed");
  self endon("death");
  self.owner endon("disconnect");

  if(isDefined(attacker)) {
    attacker endon("disconnect");
  } else {
    attacker = self.owner;
  }

  self notify("mine_triggered");
  printgameaction("claymore triggered", self.owner);

  if(isent(self)) {
    makeexplosiveunusuabletag();
  }

  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  graceperiod = default_to(self.bundle.claymore_graceperiod, 0);
  explosivetrigger(ent, graceperiod);
  thread claymore_explode(attacker);
}

function claymore_triggerfromvehicle(vehicle, mine) {
  mine endon("mine_destroyed");
  mine endon("death");
  mine.owner endon("disconnect");
  mine notify("mine_triggered");
  mine makeexplosiveunusuabletag();
  mine setscriptablepartstate("arm", "neutral", 0);
  mine setscriptablepartstate("trigger", "active", 0);
  wait mine.bundle.var_da8863dc7605cb83;
  mine thread claymore_explodefromvehicletrigger(vehicle);
}

function claymore_explodefromvehicletrigger(vehicle) {
  vehicle dodamage(self.bundle.var_1686cbcbae48a0fe, self.origin, self.owner, self, "MOD_EXPLOSIVE", makeweapon("claymore_mp"));
  ignoredamageid = vehicle scripts\mp\utility\damage::non_player_add_ignore_damage_signature(self.owner, makeweapon("claymore_mp"), self, "MOD_EXPLOSIVE");
  thread claymore_explode();
  waitframe();

  if(isDefined(vehicle)) {
    vehicle scripts\mp\utility\damage::non_player_remove_ignore_damage_signature(ignoredamageid);
  }
}

function claymore_explode(attacker) {
  self setscriptablepartstate("plant", "neutral", 0);
  self setscriptablepartstate("trigger", "neutral", 0);
  self setscriptablepartstate("explode", "active", 0);

  if(self getscriptablehaspart("health")) {
    self setscriptablepartstate("health", "ignore_damage", 0);
  }

  if(isent(self)) {
    level.mines[self getentitynumber()] = undefined;
    self setCanDamage(0);
    scripts\cp_mp\ent_manager::deregisterspawn();
    makeexplosiveunusuabletag();
  }

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  self.exploding = 1;
  owner = self.owner;

  if(isDefined(self.owner)) {
    owner removeequip(self);
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  forward = anglestoup(self.angles);
  right = -1 * anglestoright(self.angles);
  up = anglesToForward(self.angles);
  playFX(getfx("claymore_explode"), self.origin, forward, up);

  if(isent(self)) {
    var_25144f9160d59fd = self;
  } else if(isent(owner)) {
    var_25144f9160d59fd = owner;

    if(!isDefined(owner.var_2e8bbe611a66d602)) {
      owner.var_2e8bbe611a66d602 = [];
    }

    if(!isDefined(owner.var_2e8bbe611a66d602["claymore_mp"])) {
      owner.var_2e8bbe611a66d602["claymore_mp"] = [];
    }

    owner.var_2e8bbe611a66d602["claymore_mp"][owner.var_2e8bbe611a66d602["claymore_mp"].size] = self.index;
  }

  if(isDefined(var_25144f9160d59fd)) {
    var_25144f9160d59fd radiusdamage(self.origin, self.bundle.var_2870c709e5604e6f, self.bundle.var_ef43b82f36673cc, self.bundle.var_f184982f38f0d4e, self.owner, "MOD_EXPLOSIVE", isDefined(self.bundle.var_81e0f871add9f577) ? self.bundle.var_81e0f871add9f577 : "claymore_radial_mp");
  }

  earthquake(0.45, 0.7, self.origin, 800);

  if(isent(self)) {
    self detonate(attacker);
  }
}

function claymore_explodeonnotify() {
  self endon("death");
  level endon("game_ended");
  owner = self.owner;
  self waittill("detonateExplosive", attacker);
  self.detonatingplayer = attacker;
  self setscriptablepartstate("arm", "neutral", 0);
  self setscriptablepartstate("trigger", "active", 0);
  self notify("mine_triggered");
  thread claymore_explode(attacker);
}

function sweepclaymore() {
  claymore_destroy();
}

function claymore_destroy(destroydelay) {
  if(!isDefined(destroydelay)) {
    destroydelay = 0;
  }

  thread claymore_delete(destroydelay + 0.2);
  wait destroydelay;
  self setscriptablepartstate("destroy", "active", 0);
}

function claymore_empapplied(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker)) || getdvarint(@ "hash_58254c61de76bffe", 0)) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  damagefeedback = "";

  if(istrue(self.hasruggedeqp)) {
    damagefeedback = "hitequip";
  }

  if(isPlayer(attacker)) {
    attacker updatedamagefeedback(damagefeedback);
  }

  thread function_8ebab9db1b5be748(attacker);
}

function function_ac5843028846c67(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self, undefined, 1);
  }

  damagefeedback = "";

  if(istrue(self.hasruggedeqp)) {
    damagefeedback = "hitequip";
  }

  if(isPlayer(attacker)) {
    attacker updatedamagefeedback(damagefeedback);
  }

  thread function_6d0e1341e170c6(attacker);
}

function function_4373872960a2d51a(data) {
  attacker = data.attacker;

  if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, attacker))) {
    attacker notify("destroyed_equipment");
    attacker scripts\mp\killstreaks\killstreaks::givescoreforequipment(self);
  }

  damagefeedback = "";

  if(istrue(self.hasruggedeqp)) {
    damagefeedback = "hitequip";
  }

  if(isPlayer(attacker)) {
    attacker updatedamagefeedback(damagefeedback);
  }

  claymore_explode(attacker);
}

function function_8ebab9db1b5be748(attacker) {
  self endon("death");
  self setscriptablepartstate("empd", "active", 0);
  claymore_stunned(attacker, 6);
  self setscriptablepartstate("empd", "neutral", 0);
}

function function_6d0e1341e170c6(attacker) {
  self endon("death");
  self setscriptablepartstate("empd", "active", 0);
  function_3120a2693959efa1(attacker);
}

function claymore_delete(deletiondelay) {
  if(!isDefined(deletiondelay)) {
    deletiondelay = 0;
  }

  self setscriptablepartstate("hack_usable", "off");
  self notify("death");
  scripts\cp_mp\ent_manager::deregisterspawn();

  if(isent(self)) {
    level.mines[self getentitynumber()] = undefined;
    self setCanDamage(0);
    makeexplosiveunusuabletag();
  } else if(isDefined(level.var_8106ad57bb892525) && isDefined(level.var_8106ad57bb892525[self.index])) {
    level.var_8106ad57bb892525[self.index] = undefined;
  }

  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(self.headiconid);
  self.headiconid = undefined;
  self.exploding = 1;

  if(isDefined(self.dangerzone)) {
    scripts\mp\spawnlogic::removespawndangerzone(self.dangerzone);
    self.dangerzone = undefined;
  }

  owner = self.owner;

  if(isDefined(self.owner)) {
    owner removeequip(self);
  }

  if(isDefined(deletiondelay)) {
    wait deletiondelay;
  }

  if(isent(self)) {
    self delete();
    return;
  }

  self freescriptable();
}

function claymore_modifieddamage(victim, objweapon, inflictor, meansofdeath, damage) {
  if(!isDefined(inflictor)) {
    return damage;
  }

  if(isnullweapon(objweapon)) {
    return damage;
  }

  tableinfo = scripts\cp_mp\equipment::getequipmenttableinfo("equip_claymore");
  bundle = tableinfo.bundle;

  if(isDefined(inflictor.owner)) {
    attacker = inflictor.owner;
    claymoreorigin = inflictor.origin;
    var_81af81c5d73867c1 = inflictor.angles;
  } else if(isDefined(inflictor.team) && isagent(inflictor) && objweapon.basename == (isDefined(bundle.var_81e0f871add9f577) ? bundle.var_81e0f871add9f577 : "claymore_radial_mp")) {
    attacker = inflictor;

    if(isDefined(attacker.var_2e8bbe611a66d602) && isDefined(attacker.var_2e8bbe611a66d602["claymore_mp"])) {
      foreach(explosiveid in attacker.var_2e8bbe611a66d602["claymore_mp"]) {
        explosive = level.var_8106ad57bb892525[explosiveid];
        claymoreorigin = explosive.origin;
        var_81af81c5d73867c1 = explosive.angles;
        attacker.var_2e8bbe611a66d602["claymore_mp"] = array_remove(attacker.var_2e8bbe611a66d602["claymore_mp"], explosiveid);
        break;
      }
    } else {
      assertmsg("<dev string:x1c>");
    }
  }

  if(objweapon.basename == "claymore_mp") {
    if(isDefined(self.claymoreshitby)) {
      foreach(claymore in self.claymoreshitby) {
        if(isDefined(claymore) && claymore == inflictor) {
          return 0;
        }
      }
    }
  } else if(objweapon.basename == (isDefined(bundle.var_81e0f871add9f577) ? bundle.var_81e0f871add9f577 : "claymore_radial_mp")) {
    if(!istrue(scripts\cp_mp\utility\player_utility::playersareenemies(victim, attacker))) {
      return 0;
    }

    thread scripts\mp\equipment\claymore::claymore_blockdamageuntilframeend(inflictor);
  } else {
    return damage;
  }

  if(isDefined(level.gametype) && scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    return damage;
  }

  if(!isexplosivedamagemod(meansofdeath)) {
    return damage;
  }

  btwn = victim.origin - claymoreorigin;
  dist = vectordot(btwn, anglestoup(var_81af81c5d73867c1));

  if(dist > 65) {
    return 0;
  }

  btwn = claymoreorigin - victim getEye();
  dist = vectordot(btwn, anglestoup(var_81af81c5d73867c1));

  if(dist > 65) {
    return 0;
  }

  forward = anglesToForward(var_81af81c5d73867c1);
  forward = (forward[0], forward[1], 0);
  disp = victim.origin - claymoreorigin;
  disp = (disp[0], disp[1], 0);
  dot = vectordot(forward, disp);

  if(dot < 0) {
    return 0;
  }

  dist = distance2d(claymoreorigin, victim.origin);
  ratio = 1 - clamp((dist - bundle.var_97202c494b76611a) / (bundle.var_974316494b9c7870 - bundle.var_97202c494b76611a), 0, 1);
  damage = bundle.var_f184982f38f0d4e + (bundle.var_974316494b9c7870 - bundle.var_97202c494b76611a) * ratio;

  if(isDefined(inflictor.detonatingplayer)) {
    var_68c7b0cd4c501af6 = isDefined(inflictor.owner) && inflictor.detonatingplayer == inflictor.owner;
    var_a38dc5334101941b = inflictor.detonatingplayer == victim;

    if(!var_68c7b0cd4c501af6 && var_a38dc5334101941b) {
      damage = min(damage, 80);
    }
  }

  return damage;
}

function claymore_blockdamageuntilframeend(inflictor) {
  self endon("disconnect");
  self notify("claymore_blockDamageUntilFrameEnd");
  self endon("claymore_blockDamageUntilFrameEnd");

  if(!isDefined(self.claymoreshitby)) {
    self.claymoreshitby = [];
  }

  self.claymoreshitby[self.claymoreshitby.size] = inflictor;
  waittillframeend();
  self.claymoreshitby = undefined;
}

function claymore_onownerchanged(oldowner) {
  self setscriptablepartstate("hacked", "active", 0);
  claymore_updatedangerzone();
  makeexplosiveunusuabletag();
  sentientpool = self.sentientpool;
  scripts\mp\sentientpoolmanager::unregistersentient(self.sentientpool, self.sentientpoolindex);
  scripts\mp\sentientpoolmanager::registersentient(sentientpool, self.owner, 1);
  thread monitordisownedequipment(self.owner, self);
  thread outlineequipmentforowner(self);
}

function claymore_stunned(attacker, duration) {
  self endon("death");

  if(!isDefined(duration)) {
    duration = self.bundle.claymore_stunduration;
  }

  if(isPlayer(attacker)) {
    attacker updatedamagefeedback("hitequip");
  }

  self notify("claymore_stunned");
  self endon("claymore_stunned");
  attacker thread scripts\mp\utility\points::doscoreevent(#"disabled_claymore");
  self setscriptablepartstate("arm", "neutral", 0);
  self.stunned = 1;
  wait duration;
  self.stunned = 0;
  self setscriptablepartstate("arm", "active", 0);
}

function function_3120a2693959efa1(attacker) {
  self endon("death");

  if(isPlayer(attacker)) {
    attacker updatedamagefeedback("hitequip");
  }

  self notify("claymore_stunned");
  self endon("claymore_stunned");
  attacker thread scripts\mp\utility\points::doscoreevent(#"disabled_claymore");
  self setscriptablepartstate("arm", "neutral", 0);
  self.stunned = 1;
}

function function_b3a55145aba7855e(data) {
  self.stunned = 0;
  self setscriptablepartstate("arm", "active", 0);
}

function function_49197cd063a740ea(callbackfunction) {
  self.elevatordoorsclosecallback = callbackfunction;
}

function function_773e48f8d031510e() {
  self endon("mine_destroyed");
  self endon("death");
  level waittill_any_2("game_ended", "bro_shot_start");
  thread claymore_destroy();
}

function function_a05a0b89582e22a3() {
  self endon("mine_destroyed");
  self endon("death");
  self waittill("entity_limit_destroy");
  claymore_destroy();
}