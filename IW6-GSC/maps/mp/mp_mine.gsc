/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_mine.gsc
*****************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;

CONST_KILLSTREAK_NAME = "mine_level_killstreak";
CONST_KILLSTREAK_WEAPON = "killstreak_minemarker_mp";
CONST_DEBUG_NAME = "Mine Killstreak";
CONST_KILLSTREAK_LOC_NAME = &"MP_MINE_LEVEL_KILLSTREAK";
CONST_KILLSTREAK_PICKUP = &"MP_MINE_LEVEL_KILLSTREAK_PICKUP";
CONST_CRATE_WEIGHT = 90;

main() {
  maps\mp\mp_mine_precache::main();
  maps\createart\mp_mine_art::main();
  maps\mp\mp_mine_fx::main();

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_mine");

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  SetDvar("r_tessellationCutoffFalloffBase", 600);
  SetDvar("r_tessellationCutoffDistanceBase", 2000);
  SetDvar("r_tessellationCutoffFalloff", 600);
  SetDvar("r_tessellationCutoffDistance", 2000);
  SetDvar("r_reactiveMotionWindFrequencyScale", 0.1);
  SetDvar("sm_sunSampleSizeNear", 0.43);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  level.minecartWheelAnims = ["mp_cart_idle_anim", "mp_cart_spin_slow_anim", "mp_cart_spin_mid_anim", "mp_cart_spin_fast_anim"];

  thread setupElevator();
  thread MineCartSetup("cart1", "cart1TrackStart", "cart1AttachedModels", "cart1dmg", "cart1_inside", "cart1_front");
  thread MineCartSetup("cart2", "cart2TrackStart", "cart2AttachedModels", "cart2dmg", "cart2_interior", "cart2_front");
  thread setupElevatorKillTrigger();

  initKillstreak();

  thread maps\mp\_dlcalienegg::setupEggForMap("alienEasterEgg");

  wildlife();
  thread ambientAnimations();

  level._effect["gear_blood"] = LoadFX("vfx/moments/mp_zerosub/vfx_blood_explosion");

  thread setupPushTrigger("pushTrigger01", (10, 90, 0));
  thread setupPushTrigger("pushTrigger02", (10, 180, 0));

  thread setupPushTrigger("pushTrigger04", (10, 270, 0));
}

setupGameTypeFlags(elevator) {
  level.mineBFlag = undefined;
  objectives = [];

  if(level.gameType == "dom" || level.gameType == "siege") {
    objectives = getEntArray("flag_primary", "targetname");
  } else {
    return;
  }

  foreach(f in objectives) {
    if(isDefined(f.script_label) && f.script_label == "_b") {
      level.mineBFlag = f;
      break;
    }
  }

  if(isDefined(level.mineBFlag)) {
    level thread updateBFlagObjIcon();

    domFlag = getDomFlagB();
    domflag EnableLinkTo();
    domflag LinkTo(ELEVATOR);

    while(!isDefined(domflag.useObj)) {
      waitframe();
    }
    foreach(vis in domflag.useObj.visuals) {
      vis LinkTo(ELEVATOR);
    }
  }
}

getDomFlagB() {
  return level.mineBFlag;
}

BASE_EFFECT_OFFSET_GOING_DOWN = 1.5;
BASE_EFFECT_OFFSET_GOING_UP = 16;

updateBFlagFxPos(goingUp, loop) {
  level endon("mp_mine_elevator_stopped");

  bFlag = getDomFlagB();
  if(!isDefined(bFlag)) {
    return;
  }
  offset = ter_op(goingUp, BASE_EFFECT_OFFSET_GOING_UP, BASE_EFFECT_OFFSET_GOING_DOWN);

  while(true) {
    fxOrigin = bFlag.origin + (0, 0, offset);
    bFlag.useObj.baseEffectPos = fxOrigin;

    if(isDefined(bFlag.useObj.neutralFlagFx)) {
      bFlag.useObj.neutralFlagFx.origin = fxOrigin;
      TriggerFX(bFlag.useObj.neutralFlagFx);
    }

    foreach(player in level.players) {
      if(isDefined(player._domFlagEffect) && isDefined(player._domFlagEffect["_b"])) {
        player._domFlagEffect["_b"].origin = fxOrigin;
        TriggerFX(player._domFlagEffect["_b"]);
      }
    }

    if(!loop) {
      break;
    }
    wait 0.25;
  }
}

updateBFlagObjIcon() {
  bFlag = getDomFlagB();
  while(!isDefined(bFlag.useObj)) {
    waitframe();
  }

  tag_origin = spawn_tag_origin();
  tag_origin show();
  tag_origin.origin = bFlag.origin + (0, 0, 100);
  tag_origin LinkTo(bFlag);
  bFlag.useObj.objIconEnt = tag_origin;
  bFlag.useObj maps\mp\gametypes\_gameobjects::updateWorldIcons();
}

setupElevator() {
  ELEVATOR = GetEnt("elevator", "targetname");
  GEARS = GetEnt("elevatorGears", "targetname");
  BLOCKER = GetEnt("elevatorPathNodeHolders", "targetname");
  BLOCKERTOP = GetEnt("elevatorPathNodeTop", "targetname");
  BLOCKERMID = GetEnt("elevatorPathNodeMid", "targetname");
  BLOCKERBOT = GetEnt("elevatorPathNodeBot", "targetname");
  MOVETIME = 6;
  WAITTIME = 20;
  STRUCTTOP = getstruct("elevatorTop", "targetname");
  STRUCTBOT = getstruct("elevatorBot", "targetname");

  ELEVATORMODELS = getEntArray("elevatorAttachedModels", "targetname");
  foreach(detail in ELEVATORMODELS) {
    detail LinkTo(ELEVATOR);
  }
  ELEVATORKILL = GetEnt("elevatorDamage", "targetname");
  ELEVATORKILL EnableLinkTo();
  ELEVATORKILL LinkTo(ELEVATOR);

  GEARKILL = ELEVATOR linkTrigger("elevatorGearCrushTrigger");

  BEAMKILL = GetEnt("elevatorSquish", "targetname");
  BEAMKILL.dmg = 0;

  ELEVATOR ConnectPaths();
  BLOCKER Hide();
  BLOCKER NotSolid();
  BLOCKERTOP Hide();
  BLOCKERTOP NotSolid();

  setupGameTypeFlags(ELEVATOR);

  blockerConnect(BLOCKERTOP);

  leftSoundEnt = GetEnt("elevatorWheelLeft", "targetname");
  leftSoundEnt LinkTo(GEARS);

  rightSoundEnt = GetEnt("elevatorWheelRight", "targetname");
  rightSoundEnt LinkTo(GEARS);

  wait 10;

  while(true) {
    GEARS RotatePitch(-1 * 256.1, MOVETIME, 1, 1);
    GEARS MoveTo((-59, 256, 287), MOVETIME, 1, 1);
    ELEVATOR MoveTo(STRUCTBOT.origin, MOVETIME, 1, 1);
    ELEVATORKILL.dmg = 1000;
    ELEVATOR.destroyDroneOnCollision = true;
    ELEVATOR.destroyAirdropOnCollision = true;

    level thread updateBFlagFxPos(false, true);

    leftSoundEnt PlaySoundOnMovingEnt("mine_elev_big_01");
    rightSoundEnt PlaySoundOnMovingEnt("mine_elev_big_02");

    blockerConnect(BLOCKERMID);
    wait 2;

    wait 2;
    blockerDisconnect(BLOCKERTOP);
    blockerConnect(BLOCKERBOT);
    wait 2;
    blockerDisconnect(BLOCKERMID);

    level notify("mp_mine_elevator_stopped");
    level updateBFlagFxPos(false, false);
    wait WAITTIME;

    GEARS RotatePitch(1 * 256.1, MOVETIME, 1, 1);
    GEARS MoveTo((-59, 256, 543), MOVETIME, 1, 1);
    ELEVATOR MoveTo(STRUCTTOP.origin, MOVETIME, 1, 1);
    ELEVATORKILL.dmg = 0;
    ELEVATOR.destroyDroneOnCollision = false;
    ELEVATOR.destroyAirdropOnCollision = false;

    level thread updateBFlagFxPos(true, true);

    leftSoundEnt PlaySoundOnMovingEnt("mine_elev_big_01");
    rightSoundEnt PlaySoundOnMovingEnt("mine_elev_big_02");

    blockerConnect(BLOCKERMID);
    wait 2;

    GEARKILL thread crushPlayerInTrigger();
    BEAMKILL.dmg = 1000;

    blockerDisconnect(BLOCKERBOT);
    blockerConnect(BLOCKERTOP);
    wait 2;

    wait 2;
    blockerDisconnect(BLOCKERMID);

    GEARKILL notify("stopCrushing");
    BEAMKILL.dmg = 0;

    level notify("mp_mine_elevator_stopped");
    level updateBFlagFxPos(false, false);
    wait WAITTIME;
  }

}

blockerConnect(BLOCKENT) {
  BLOCKENT Show();
  BLOCKENT Solid();
  BLOCKENT ConnectPaths();
  BLOCKENT Hide();
  BLOCKENT NotSolid();
}

blockerDisconnect(BLOCKENT) {
  BLOCKENT Show();
  BLOCKENT Solid();
  BLOCKENT DisconnectPaths();
}

elevatorStartGears(floorName) {
  gears = getEntArray("elevatorGears", "targetname");
  if(floorName == self.destinationNames[0]) {
    foreach(gear in gears) {
      gear RotatePitch(1 * 360, self.moveTime, 0, 0);
      gear MoveTo((-59, 256, 543), self.moveTime, 0, 0);
    }

    self maps\mp\_elevator_v2::elevatorClearPath("elevatorMid");

    wait(5);

    self maps\mp\_elevator_v2::elevatorBlockPath("elevatorMid");
  } else {
    foreach(gear in gears) {
      gear RotatePitch(-1 * 360, self.moveTime, 0, 0);
      gear MoveTo((-59, 256, 287), self.moveTime, 0, 0);
    }

    self maps\mp\_elevator_v2::elevatorClearPath("elevatorMid");

    wait(5);

    self maps\mp\_elevator_v2::elevatorBlockPath("elevatorMid");
  }

}

MINE_CART_SLOW_SPEED_LIMIT = 250;
MineCartSetup(CartName, FirstNode, LinkedModels, DamageTrigger, insideTriggerName, frontTriggerName) {
  MINE_CART = GetEnt(CartName, "targetname");
  MINE_CART_SPEED = 1.0 / MINE_CART_SLOW_SPEED_LIMIT;
  MINE_CART_DESTINATION = getstruct(FirstNode, "targetname");

  insideTrigger = MINE_CART linkTrigger(insideTriggerName);
  MINE_CART thread setupMineCartInsideTrigger(insideTrigger);

  frontTrigger = MINE_CART linkTrigger(frontTriggerName);
  MINE_CART thread setupMineCartFrontTrigger(frontTrigger);

  CartModels = getEntArray(LinkedModels, "targetname");
  foreach(detail in CartModels) {
    detail LinkTo(MINE_CART);
    detail.destroyDroneOnCollision = false;
    detail.destroyAirdropOnCollision = true;
  }
  MINE_CART.destroyDroneOnCollision = false;
  MINE_CART.destroyAirdropOnCollision = true;

  killCamEnt = spawn("script_model", MINE_CART.origin + (0, 0, 60));
  killCamEnt LinkTo(MINE_CART);
  MINE_CART.killCamEnt = killCamEnt;
  MINE_CART.killCamEnt SetScriptMoverKillCam("explosive");

  MINE_CART.unresolved_collision_func = ::cart_unresolved_collision_func;
  MINE_CART.unresolved_collision_notify_min = 6;

  MINE_CART mineCartSetupSparks();

  MINE_CART moveTo(MINE_CART_DESTINATION.origin, .1, 0, 0);
  MINE_CART rotateTo(MINE_CART_DESTINATION.angles, .1, 0, 0);

  MINE_CART.cartmodel = CartModels[0];
  MINE_CART mineCartHandleEvents(MINE_CART_DESTINATION.script_noteworthy);

  MINE_CART.speed = 0;

  wait(.5);

  curObjID = maps\mp\gametypes\_gameobjects::getNextObjID();
  Objective_Add(curObjID, "active", MINE_CART.origin, "mine_cart_icon");
  Objective_OnEntityWithRotation(curObjID, MINE_CART);
  MINE_CART.curObjID = curObjID;

  while(true) {
    if(isDefined(MINE_CART_DESTINATION.script_label)) {
      speed = float(MINE_CART_DESTINATION.script_label);
      MINE_CART_SPEED = 1.0 / speed;
      MINE_CART.speed = speed;

      MINE_CART mineCartPlaySparksOnSpeedChange(int(MINE_CART_DESTINATION.script_label));
    }
    if(MINE_CART_DESTINATION.targetname == "cart2TrackStart") {
      thread MineCartElevatorMove(MINE_CART_SPEED);
    }
    MINE_CART_DESTINATION = MineCartMove(MINE_CART, MINE_CART_DESTINATION, MINE_CART_SPEED);

  }
}

MineCartMove(Cart, CurrentNode, CartSpeed) {
  Cart endon("death");

  NEXT_NODE = getstruct(CurrentNode.target, "targetname");
  MOVE_TIME = abs(Distance(Cart.origin, NEXT_NODE.origin) * CartSpeed);
  Cart MoveTo(NEXT_NODE.origin, MOVE_TIME, 0, 0);
  Cart RotateTo(NEXT_NODE.angles, MOVE_TIME, 0, 0);
  wait(MOVE_TIME);

  Cart mineCartHandleEvents(NEXT_NODE.script_noteworthy);

  return NEXT_NODE;
}

MineCartElevatorMove(ElevatorSpeed) {
  CARTELEVATE = GetEnt("cart2Elevator", "targetname");
  ELEVATENODEBOT = getstruct("cart2TrackStart", "targetname");
  ELEVATENODETOP = getstruct("cart2ElevatorTop", "targetname");
  BLOCKERTOP = GetEnt("cartElevatorPathNodeTop", "targetname");
  BLOCKERBOT = GetEnt("cartElevatorPathNodeBot", "targetname");
  ELEVATEMOVETIME = abs(Distance(ELEVATENODEBOT.origin, ELEVATENODETOP.origin) * ElevatorSpeed);

  CARTELEVATE.unresolved_collision_kill = true;

  CARTELEVATE.destroyDroneOnCollision = false;
  CARTELEVATE PlaySoundOnMovingEnt("minecart2_elevator_up");
  CARTELEVATE MoveTo(ELEVATENODETOP.origin, ELEVATEMOVETIME, 0, 0);
  blockerDisconnect(BLOCKERBOT);
  wait(ELEVATEMOVETIME);
  blockerConnect(BLOCKERTOP);
  wait(5);
  blockerDisconnect(BLOCKERTOP);

  CARTELEVATE.destroyDroneOnCollision = true;
  CARTELEVATE PlaySoundOnMovingEnt("minecart2_elevator_down");
  CARTELEVATE MoveTo(ELEVATENODEBOT.origin, ELEVATEMOVETIME, 0, 0);
  wait(ELEVATEMOVETIME - 2);
  trigger_on("cart2ElevatorKill", "targetname");
  wait(2);
  trigger_off("cart2ElevatorKill", "targetname");
  blockerConnect(BLOCKERBOT);
}

setupElevatorKillTrigger() {
  trigger_off("cart2ElevatorKill", "targetname");
}

linkTrigger(triggerName) {
  trigger = GetEnt(triggerName, "targetname");
  if(isDefined(trigger)) {
    trigger EnableLinkTo();
    trigger LinkTo(self);
  }

  return trigger;
}

setupMineCartFrontTrigger(frontTrigger) {
  level endon("game_ended");

  if(!isDefined(frontTrigger)) {
    return;
  }
  while(true) {
    frontTrigger waittill("trigger", otherPlayer);

    if(IsPlayer(otherPlayer) || IsAgent(otherPlayer)) {
      if(isReallyAlive(otherPlayer) && self.speed >= MINE_CART_SLOW_SPEED_LIMIT) {
        if(otherPlayer IsMantling()) {
          continue;
        }
        enemyRider = undefined;
        if(self.playersInCart.size > 0) {
          foreach(rider in self.playersInCart) {
            if(isReallyAlive(rider) && otherPlayer isEnemy(rider)) {
              enemyRider = rider;
              break;
            }
          }
        }

        damageDirection = otherPlayer.origin - self.origin;
        attacker = undefined;
        inflictor = undefined;
        damageVal = 20;
        if(isDefined(enemyRider)) {
          damageVal = 100;
          attacker = enemyRider;
          inflictor = self.killCamEnt;
        } else if(level.hardcoreMode) {
          damageVal = 100;
        } else if(IsAgent(otherPlayer)) {
          damageVal = 50;
        }

        damageCallback = level.callbackPlayerDamage;
        if(IsAgent(otherPlayer)) {
          damageCallback = maps\mp\agents\_agent_common::CodeCallback_AgentDamaged;
        }

        otherPlayer thread[[damageCallback]](
          inflictor,
          attacker,
          damageVal,
          0,
          "MOD_EXPLOSIVE",
          "iw6_minecart_mp",
          self.origin,
          damageDirection,
          "none",
          0
        );

        wait(.2);
      }
    }

    wait(0.05);
  }
}

setupMineCartInsideTrigger(insideTrigger) {
  level endon("game_ended");

  self.playersInCart = [];

  if(!isDefined(insideTrigger)) {
    return;
  }
  while(true) {
    insideTrigger waittill("trigger", player);

    if(IsPlayer(player) && isReallyAlive(player)) {
      entNum = player GetEntityNumber();

      if(!isDefined(self.playersInCart[entNum])) {
        self.playersInCart[entNum] = player;

        if(self.playersInCart.size == 1) {
          self thread waitForRiderExit(insideTrigger);
        }
      }
    }

    wait(0.05);
  }
}

waitForRiderExit(insideTrigger) {
  level endon("game_ended");

  while(self.playersInCart.size > 0) {
    foreach(index, player in self.playersInCart) {
      if(!isDefined(player) ||
        !isReallyAlive(player) ||
        !player IsTouching(insideTrigger)
      ) {
        self.playersInCart[index] = undefined;
      }
    }

    wait(0.05);
  }
}

mineCartSetupSparks() {
  level._effect["cart_sparks"] = LoadFX("vfx/moments/mp_mine/vfx_track_sparks_child");
  level._effect["cart_sparks_loop"] = LoadFX("vfx/moments/mp_mine/vfx_track_sparks_loop");
  self.lastSpeed = 10;
  self.sparkTimeStamp = 0;
}

CONST_SPARK_SPEED_LIMIT = 20;
CONST_SPARK_FREQUENCY = 3500;
mineCartPlaySparksOnSpeedChange(targetSpeed) {
  if(isDefined(targetSpeed) &&
    GetTime() > self.sparkTimeStamp &&
    abs(targetSpeed - self.lastSpeed) > CONST_SPARK_SPEED_LIMIT
  ) {
    self.lastSpeed = targetSpeed;
    self.sparkTimeStamp = GetTime() + CONST_SPARK_FREQUENCY;

    self thread mineCartPlaySparks("cart_sparks");
  }
}

CONST_REAR_SCALE = 1;
CONST_RIGHT_SCALE = 18;
CONST_TAG_WHEEL_L = "tag_wheelL";
CONST_TAG_WHEEL_R = "tag_wheelR";
mineCartPlaySparks(fxName) {
  playFXOnTag(getfx(fxName), self.cartmodel, CONST_TAG_WHEEL_L);
  playFXOnTag(getfx(fxName), self.cartmodel, CONST_TAG_WHEEL_R);
}

mineCartStopSparks(fxName) {
  stopFXOnTag(getfx(fxName), self.cartmodel, CONST_TAG_WHEEL_L);
  stopFXOnTag(getfx(fxName), self.cartmodel, CONST_TAG_WHEEL_R);
}

mineCartHandleEvents(node_noteworthy) {
  if(!isDefined(node_noteworthy)) {
    return;
  }
  tokens = StrTok(node_noteworthy, ",");

  foreach(token in tokens) {
    if(isStrStart(token, "sfx=")) {
      sfxName = GetSubStr(token, 4, token.size);

      self PlaySoundOnMovingEnt(sfxName);
    } else if(isStrStart(token, "loop=")) {
      sfxName = GetSubStr(token, 5, token.size);
      self playLoopSound(sfxName);
    } else if(token == "loopstop") {
      self StopLoopSound();
    } else if(token == "vfx") {
      self thread mineCartPlaySparks("cart_sparks");
    } else if(token == "vfxStart") {
      self thread mineCartPlaySparks("cart_sparks_loop");
    } else if(token == "vfxStop") {
      self mineCartStopSparks("cart_sparks_loop");
    } else if(isStrStart(token, "wheelSpeed=")) {
      wheelAnimId = Int(GetSubStr(token, 11, token.size));
      if(wheelAnimId < level.minecartWheelAnims.size) {
        self.cartmodel ScriptModelPlayAnim(level.minecartWheelAnims[wheelAnimId]);
      }
    }
  }
}

initKillstreak() {
  level.mapCustomKillstreakFunc = ::customKillstreakFunc;
  level.mapCustomCrateFunc = ::customCrateFunc;
  level.mapCustomBotKillstreakFunc = ::customBotKillstreakFunc;

  AddDebugCommand("bind p \"set scr_givekillstreak " + CONST_KILLSTREAK_NAME + "\"\n");
}

customCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"]))
    game["player_holding_level_killstrek"] = false;

  if(!allowLevelKillstreaks() || game["player_holding_level_killstrek"]) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault",
    CONST_KILLSTREAK_NAME,
    CONST_CRATE_WEIGHT,
    maps\mp\killstreaks\_airdrop::killstreakCrateThink,
    maps\mp\killstreaks\_airdrop::get_friendly_crate_model(),
    maps\mp\killstreaks\_airdrop::get_enemy_crate_model(),
    CONST_KILLSTREAK_PICKUP
  );
  level thread watchForCrateUse();
}

watchForCrateUse() {
  while(true) {
    level waittill("createAirDropCrate", dropCrate);

    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == CONST_KILLSTREAK_NAME) {
      maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", CONST_KILLSTREAK_NAME, 0);
      captured = wait_for_capture(dropCrate);

      if(!captured) {
        maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", CONST_KILLSTREAK_NAME, CONST_CRATE_WEIGHT);
      } else {
        game["player_holding_level_killstrek"] = true;
        break;
      }
    }
  }
}

wait_for_capture(dropCrate) {
  result = watch_for_air_drop_death(dropCrate);
  return !isDefined(result);
}

watch_for_air_drop_death(dropCrate) {
  dropCrate endon("captured");

  dropCrate waittill("death");
  waittillframeend;

  return true;
}

customKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/" + CONST_DEBUG_NAME + "\" \"set scr_devgivecarepackage " + CONST_KILLSTREAK_NAME + "; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/" + CONST_DEBUG_NAME + "\" \"set scr_givekillstreak " + CONST_KILLSTREAK_NAME + "\"\n");

  maps\mp\killstreaks\mp_wolfpack_killstreak::init();

  level.killstreakWeildWeapons["iw6_minecart_mp"] = "iw6_minecart_mp";
}

customBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Bots(Killstreak)/Level Events:5/" + CONST_DEBUG_NAME + "\" \"set scr_testclients_givekillstreak " + CONST_KILLSTREAK_NAME + "\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func(CONST_KILLSTREAK_NAME, maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

ambientAnimations() {
  wait(3);

  wheels = GetEnt("spinny_wheels", "targetname");
  if(isDefined(wheels)) {
    wheels ScriptModelPlayAnim("mp_mine_spinning_wheels");
  }
}

wildlife() {
  thread maps\interactive_models\vulture_mp::vulture_circling((565, -1870, 1500), 3);
  thread maps\interactive_models\vulture_mp::vulture_circling((-300, 1210, 1650), 2);
  /#thread maps\interactive_models\vulture_mp::vultures_toggle_thread();

  thread maps\interactive_models\batcave::vfxBatCaveWaitInit("bats_flyaway_1", 1, "vfx_bats_flyaway_1", (-2028.06, 464.427, 413.921));
  thread maps\interactive_models\batcave::vfxBatCaveWaitInit("bats_flyaway_2", 2, "vfx_bats_flyaway_2", (-264.3, 927.7, 397.8), 2);
}

crushPlayerInTrigger() {
  level endon("game_ended");
  self endon("stopCrushing");

  while(true) {
    self waittill("trigger", player);

    if(isReallyAlive(player)) {
      player DoDamage(1000, player.origin, undefined, undefined, "MOD_CRUSH");

      player notify("notify_moving_platform_invalid");

      if(IsPlayer(player) || IsAgent(player)) {
        thread cleanupCrushedbody(player GetCorpseEntity());
      }
    }
  }
}

cleanupCrushedBody(body) {
  playFX(getfx("gear_blood"), body.origin, -1 * anglesToForward(body.angles), AnglesToUp(body.angles));

  wait(0.7);

  if(isDefined(body)) {
    playFX(getfx("gear_blood"), body.origin, -1 * anglesToForward(body.angles), AnglesToUp(body.angles));

    body Hide();
  }
}

cart_unresolved_collision_func(player, bAllowSuicide) {
  if(IsPlayer(player) && player IsLinked()) {
    player Unlink();
  }

  self maps\mp\_movers::unresolved_collision_owner_damage(player);
}

setupPushTrigger(triggerName, pushAngles) {
  level endon("game_ended");
  trigger = GetEnt(triggerName, "targetname");

  if(!isDefined(trigger)) {
    return;
  }
  while(true) {
    trigger waittill("trigger", player);

    if(IsPlayer(player) || IsAgent(player)) {
      if(player IsLinked()) {
        player Unlink();
        player.startUseMover = undefined;
      }

      dir = 100 * anglesToForward(pushAngles);
      player SetVelocity(dir);

    }

    wait 0.1;
  }
}