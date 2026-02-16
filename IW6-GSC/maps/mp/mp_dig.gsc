/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_dig.gsc
*****************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\agents\_agent_utility;
#using_animtree("multiplayer");

CONST_RA_SET = 0;
CONST_AMON_SET = 1;
CONST_HORUS_SET = 2;
CONST_ANUBIS_SET = 3;

CONST_OBELISK_ID = "obelisk_event";
CONST_SCARABS_ID = "scarabs_event";
CONST_TREASURE_ID = "treasure_event";
CONST_SNAKES_ID = "snakes_event";
CONST_SHRINE_ID = "shrine_event";

CONST_CHARACTERS = "CHARACTERS";
CONST_KILLSTREAKS = "KILLSTREAKS";
CONST_EQUIPMENT = "EQUIPMENT";
CONST_PACKAGES = "CARE PACKAGES";
CONST_INTEL = "INTEL";

CONST_SNAKE_ANIM_LENGTH = 66.7;
CONST_SCARAB_APPEAR_TIME = 2;
CONST_SCARAB_KILL_RADIUS_SQUARED = 4000;
CONST_SCARAB_DMG_TICK = 20;
CONST_SCARAB_DMG_INTERVAL = 0.5;
CONST_SCARAB_FALLOFF_TIME = 10;
CONST_OBELISK_IMPACT_TIME = 3.1;
CONST_OBELISK_FALL_ANIM_TIME = 7;
CONST_FLAME_DMG_TICK = 20;
CONST_FLAME_DMG_INTERVAL = 0.5;
CONST_FLAME_LIFE_TIME = 10;
CONST_DOOR_MOVE_TIME = 15;
CONST_CHEST_USE_TIME = 4;
CONST_CHEST_JACKPOT_LENGTH = 30;
CONST_MAX_SCARAB_DEATH_BONES = 32;

CONST_DEBUG_OBELISK = "scr_obelisk_fall";
CONST_DEBUG_OBELISK_RESET = "scr_obelisk_reset";
CONST_DEBUG_PLAYER_SCARAB = "scr_scarab_on_player";
CONST_DEBUG_PLAYER_SHRINE = "scr_shrine_on_player";
CONST_DEBUG_SCARAB_POT_RESET = "scr_scarab_pot_reset";
CONST_DEBUG_TREASURE_OPEN = "scr_treasure_open";
CONST_DEBUG_TREASURE_RESET = "scr_treasure_reset";

CONST_SCARAB_KILL_WEAPON = "iw6_scarabkill_mp";

CONST_EXPLODER_SCAFFOLD_DESTORY_1 = 10;
CONST_EXPLODER_SCAFFOLD_DESTORY_2 = 11;
CONST_EXPLODER_SCAFFOLD_DESTORY_3 = 12;
CONST_EXPLODER_SCAFFOLD_DESTORY_4 = 13;
CONST_EXPLODER_SCAFFOLD_DESTORY_5 = 14;
CONST_EXPLODER_SCAFFOLD_DESTORY_6 = 15;
CONST_EXPLODER_SCAFFOLD_DESTORY_7 = 16;
CONST_EXPLODER_OBELISK_FALL_1 = 20;
CONST_EXPLODER_OBELISK_FALL_2 = 21;
CONST_EXPLODER_OBELISK_FALL_3 = 22;
CONST_EXPLODER_SHRINE = 55;
CONST_EXPLODER_CHEST_SMOKE = 56;
CONST_EXPLODER_CHEST_FLAMES = 57;
CONST_EXPLODER_CHEST_DOOR = 59;

main() {
  maps\mp\mp_dig_precache::main();
  maps\createart\mp_dig_art::main();
  maps\mp\mp_dig_fx::main();

  level.mapCustomCrateFunc = ::digCustomCrateFunc;
  level.mapCustomKillstreakFunc = ::digCustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::digCustomBotKillstreakFunc;

  level.allow_level_killstreak = true;
  level.custom_death_sound = ::playCustomDeathSound;

  level.nukeDeathVisionFunc = ::nukeDeathVision;

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_dig");

  setdvar_cg_ng("r_specularColorScale", 2.5, 5);
  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";

  digEventExceptions = [];
  showEvents = true;

  if(level.gameType == "horde" || level.gametype == "infect")
    showEvents = false;

  if(level.gameType == "gun" || level.gametype == "sotf" || level.gametype == "sotf_ffa" || isAnyMLGMatch())
    digEventExceptions[digEventExceptions.size] = CONST_TREASURE_ID;

  setupEvents(showEvents, digEventExceptions);
  setupShrinePerks();

  thread maps\mp\_dlcalienegg::setupEggForMap("alienEasterEgg");
  thread nuke_custom_visionset();
}

precacheItems() {
  level.breakables_fx["scarabpot"]["break"] = LoadFX("vfx/moments/mp_dig/vfx_kstr_urnbreak_01");
  level.breakables_fx["scarabpot"]["break_top"] = LoadFX("vfx/moments/mp_dig/vfx_pot_smk_wispy_damage");
  level.breakables_fx["scarabpot"]["break_scarabs"] = LoadFX("vfx/moments/mp_dig/vfx_scarab_pot_explosion_r");
  level.breakables_fx["scarab"]["player"] = LoadFX("vfx/moments/mp_dig/vfx_scarab_on_player_r");
  level.breakables_fx["scarab"]["ground"] = LoadFX("vfx/moments/mp_dig/vfx_scarab_walk_up_r");
  level.breakables_fx["scarab"]["screen"] = LoadFX("vfx/moments/mp_dig/vfx_scarab_screen_r");
  level.breakables_fx["scarab"]["flyers"] = LoadFX("vfx/moments/mp_dig/vfx_scarab_groupwflyers");

  level.dig_fx["torch"]["fire"] = LoadFX("vfx/moments/mp_dig/vfx_torch_fire_03");
  level.dig_fx["torch"]["sand"] = LoadFX("vfx/moments/mp_dig/vfx_falling_sand_torch");

  level.dig_fx["shrine"]["player"] = LoadFX("vfx/moments/mp_dig/vfx_kstr_loadedguy");
  level.dig_fx["shrine"]["screen"] = LoadFX("vfx/moments/mp_dig/vfx_kstr_loadedguy_scr");
  level.dig_fx["scarab"]["deathAnim"] = LoadFX("vfx/moments/mp_dig/vfx_scarab_death_r");
  level.dig_fx["flametrap"]["player"] = LoadFX("vfx/moments/mp_dig/vfx_kstr_manflame");
  level.dig_fx["flametrap"]["screen"] = LoadFX("vfx/moments/mp_dig/vfx_kstr_fireroom_scr");
  level.dig_fx["flametrap"]["room"] = LoadFX("vfx/moments/mp_dig/vfx_kstr_flameroom_flame");
}

setupEvents(setup, setupExceptions) {
  precacheItems();

  SetDvarIfUninitialized(CONST_DEBUG_OBELISK, 0);
  SetDvarIfUninitialized(CONST_DEBUG_OBELISK_RESET, 0);
  SetDvarIfUninitialized(CONST_DEBUG_PLAYER_SCARAB, 0);
  SetDvarIfUninitialized(CONST_DEBUG_PLAYER_SHRINE, 0);
  SetDvarIfUninitialized(CONST_DEBUG_SCARAB_POT_RESET, 0);
  SetDvarIfUninitialized(CONST_DEBUG_TREASURE_OPEN, 0);
  SetDvarIfUninitialized(CONST_DEBUG_TREASURE_RESET, 0);

  AddDebugCommand("bind o \"set " + CONST_DEBUG_OBELISK + " 1\"\n");
  AddDebugCommand("bind p \"set " + CONST_DEBUG_OBELISK_RESET + " 1\"\n");
  AddDebugCommand("bind k \"set " + CONST_DEBUG_PLAYER_SCARAB + " 1\"\n");
  AddDebugCommand("bind l \"set " + CONST_DEBUG_PLAYER_SHRINE + " 1\"\n");
  AddDebugCommand("bind semicolon \"set " + CONST_DEBUG_SCARAB_POT_RESET + " 1\"\n");
  AddDebugCommand("bind u \"set " + CONST_DEBUG_TREASURE_OPEN + " 1\"\n");
  AddDebugCommand("bind i \"set " + CONST_DEBUG_TREASURE_RESET + " 1\"\n");

  level thread debugDvarWatcher(CONST_DEBUG_OBELISK);
  level thread debugDvarWatcher(CONST_DEBUG_OBELISK_RESET);
  level thread debugDvarWatcher(CONST_DEBUG_PLAYER_SCARAB);
  level thread debugDvarWatcher(CONST_DEBUG_PLAYER_SHRINE);
  level thread debugDvarWatcher(CONST_DEBUG_SCARAB_POT_RESET);
  level thread debugDvarWatcher(CONST_DEBUG_TREASURE_OPEN);
  level thread debugDvarWatcher(CONST_DEBUG_TREASURE_RESET);

  if(setup) {
    obelisk = true;
    scarabs = true;
    treasure = true;
    snakes = true;
    shrine = true;

    if(isDefined(setupExceptions) && setupExceptions.size > 0) {
      foreach(exception in setupExceptions) {
        switch (exception) {
          case CONST_OBELISK_ID:
            obelisk = false;
            break;
          case CONST_SCARABS_ID:
            scarabs = false;
            break;
          case CONST_TREASURE_ID:
            treasure = false;
            break;
          case CONST_SNAKES_ID:
            snakes = false;
            break;
          case CONST_SHRINE_ID:
            shrine = false;
            break;
        }
      }
    }

    if(obelisk)
      level thread setupObelisk();

    if(scarabs) {
      level.digScarabPots = [];
      level.digScarabPots = getStructArray("scarab_pot", "targetname");

      foreach(pot in level.digScarabPots) {
        level thread setupScarabPot(pot.origin);
      }
    }

    if(treasure) {
      level thread setupRadio();
      setupTreasureRoom();
    }

    if(snakes) {
      snakeLocation = (-362, 1982, 733);
      level thread setupSnakes(snakeLocation);
    }

    if(!shrine)
      level.allow_level_killstreak = false;
  } else {
    level thread setupObelisk(true);
  }
}

debugDvarWatcher(DVAR) {
  level endon("game_ended");

  while(true) {
    value = GetDvarInt(DVAR, 0);

    if(value > 0) {
      switch (DVAR) {
        case CONST_DEBUG_OBELISK:
          level notify("obelisk_activated");
          break;
        case CONST_DEBUG_OBELISK_RESET:
          level notify("obelisk_reset");
          break;
        case CONST_DEBUG_PLAYER_SCARAB:

          firstPlayer = undefined;

          foreach(player in level.participants) {
            if(isDefined(player) && isReallyAlive(player)) {
              if(!isDefined(firstPlayer)) {
                firstPlayer = true;
                continue;
              }

              watchScarabKill(player, true);
            }
          }
          break;
        case CONST_DEBUG_PLAYER_SHRINE:
          foreach(player in level.participants) {
            if(isDefined(player) && isReallyAlive(player) && !isDefined(player.shrineEffect)) {
              player.shrineEffect = true;
              player givePerkBonus();
            } else {
              player.shrineEffect = undefined;
              player resetPerkBonus();
            }
          }
          break;
        case CONST_DEBUG_SCARAB_POT_RESET:
          level notify("scarab_pot_reset");
          break;
        case CONST_DEBUG_TREASURE_OPEN:
          foreach(player in level.players) {
            if(isPlayer(player) && isReallyAlive(player)) {
              owner = player;

              foreach(torch in level.key_torches) {
                if(!torch.used)
                  torch activateTorch(owner);

                wait(0.5);
              }

              break;
            }
          }
          break;
        case CONST_DEBUG_TREASURE_RESET:
          level notify("treasure_room_reset");
          break;
      }
      setDvar(DVAR, 0);
    }

    wait(0.5);
  }
}

getDomFlagB() {
  domFlags = getEntArray("flag_primary", "targetname");
  bFlag = undefined;
  foreach(f in domFlags) {
    if(f.script_label == "_b") {
      bFlag = f;
      break;
    }
  }
  return bFlag;
}

updateBFlagPos(resetFlag) {
  level endon("game_ended");

  bFlag = getDomFlagB();

  if(!isDefined(level.dig_old_bflagPos))
    level.dig_old_bflagPos = bflag.origin;

  newFlag = getStruct("flag_b_after", "targetname");
  upangles = VectorToAngles((0, 0, 1));
  newFlagPos = newFlag.origin;

  if(isDefined(resetFlag) && resetFlag) {
    newFlagPos = level.dig_old_bflagPos;
    traceStart = newFlagPos + (0, 0, 32);
    traceEnd = newFlagPos + (0, 0, -32);
    trace = bulletTrace(traceStart, traceEnd, false, undefined);
    upangles = VectorToAngles(trace["normal"]);
  }

  bFlag.origin = newFlagPos;
  bFlag.useObj.curOrigin = newFlagPos;
  bFlag.useObj.visuals[0].origin = newFlagPos;
  bFlag.useObj.baseEffectPos = newFlagPos;
  bflag.useObj.baseeffectforward = anglesToForward(upangles);

  if(isDefined(bFlag.useObj.neutralFlagFx)) {
    bFlag.useObj maps\mp\gametypes\dom::playFlagNeutralFX();
  }

  foreach(player in level.players) {
    if(isDefined(player._domFlagEffect) && isDefined(player._domFlagEffect["_b"]))
      bFlag.useObj maps\mp\gametypes\dom::showCapturedBaseEffectToPlayer(bFlag.useObj.ownerTeam, player);
  }
}

updateBFlagObjIcon() {
  bFlag = getDomFlagB();

  tag_origin = spawn_tag_origin();
  tag_origin show();
  tag_origin.origin = bFlag.origin + (0, 0, 100);
  tag_origin LinkTo(bFlag);
  bFlag.useObj.objIconEnt = tag_origin;
  bFlag.useObj maps\mp\gametypes\_gameobjects::updateWorldIcons();
}

setupObelisk(stopTrigger) {
  level endon("game_ended");

  level.obeliskBefore = GetEnt("obelisk_before", "targetname");
  level.obeliskAnimated = GetEnt("obelisk_anim", "targetname");
  level.obeliskAnimated2 = GetEnt("obelisk_anim_2", "targetname");
  level.obeliskAfter = GetEnt("obelisk_after", "targetname");

  level.obeliskFloor = GetEnt("obelisk_floor", "targetname");

  level.obeliskBeforeClip = GetEnt("obelisk_before_clip", "targetname");
  level.obeliskAfterClip = GetEnt("obelisk_after_clip", "targetname");

  level.obeliskPathBlocker = GetEnt("obelisk_path_blocker", "targetname");

  level.obeliskPathHolder = GetEnt("obelisk_path_holder", "targetname");

  level.obeliskDamage = GetEnt("obelisk_damage_trigger", "targetname");

  level.obeliskKillTrigger_Ground = GetEnt("obelisk_kill_trigger", "targetname");

  level.obeliskKillTrigger_Air = GetEnt("obelisk_kill_trigger_2", "targetname");

  if(isDefined(level.obeliskAnimated))
    hideEnt(level.obeliskAnimated);

  if(isDefined(level.obeliskAnimated2))
    hideEnt(level.obeliskAnimated2);

  if(isDefined(level.obeliskFloor))
    hideEnt(level.obeliskFloor);

  if(isDefined(level.obeliskAfter))
    hideEnt(level.obeliskAfter);

  if(isDefined(level.obeliskAfterClip)) {
    if(!isDefined(level.obeliskAfterClip.killCamEnt)) {
      level.obeliskAfterClip.killCamEnt = spawn("script_model", level.obeliskAfterClip.origin + (400, -800, 400));
      level.obeliskAfterClip.killCamEnt setModel("tag_origin");
    }

    hideEnt(level.obeliskAfterClip);
  }

  if(isDefined(level.obeliskPathHolder))
    hideEnt(level.obeliskPathHolder);

  if(isDefined(level.obeliskPathBlocker)) {
    showEnt(level.obeliskPathBlocker);
    level.obeliskPathBlocker DisconnectPaths();
    level thread delayHide(level.obeliskPathBlocker, 0.05);
  }

  if(isDefined(level.obeliskKillTrigger_Ground)) {
    level.obeliskKillTrigger_Ground.dmg = 0;
    level.obeliskKillTrigger_Ground thread killAll("obelisk_impact", 5000, "MOD_CRUSH");
    level.obeliskKillTrigger_Ground trigger_off();
  }

  if(isDefined(level.obeliskKillTrigger_Air)) {
    level.obeliskKillTrigger_Air.dmg = 0;
    level.obeliskKillTrigger_Air trigger_off();
  }

  if(isDefined(level.obeliskBefore))
    showEnt(level.obeliskBefore);

  if(isDefined(level.obeliskBeforeClip))
    showEnt(level.obeliskBeforeClip);

  level.obeliskfallen = false;

  if(!isDefined(stopTrigger) || !stopTrigger) {
    level childthread watchObeliskActivation();

    level childthread resetObelisk();

    if(isDefined(level.obeliskDamage)) {
      level.obeliskDamage waittill("trigger", player);

      level.obeliskOwner = player;

      level notify("obelisk_activated");
    }
  }
}

watchObeliskActivation() {
  level waittill("obelisk_activated");

  hideEnt(level.obeliskBefore);
  hideEnt(level.obeliskBeforeClip);

  level thread delayExploder(0.24, CONST_EXPLODER_SCAFFOLD_DESTORY_1);
  level thread delayExploder(0.9, CONST_EXPLODER_SCAFFOLD_DESTORY_2);
  level thread delayExploder(1.5, CONST_EXPLODER_SCAFFOLD_DESTORY_3);
  level thread delayExploder(1.7, CONST_EXPLODER_SCAFFOLD_DESTORY_4);
  level thread delayExploder(1.8, CONST_EXPLODER_SCAFFOLD_DESTORY_5);
  level thread delayExploder(2.1, CONST_EXPLODER_SCAFFOLD_DESTORY_6);
  level thread delayExploder(2.25, CONST_EXPLODER_SCAFFOLD_DESTORY_7);
  level thread delayExploder(2.9, CONST_EXPLODER_OBELISK_FALL_1);
  level thread delayExploder(2.95, CONST_EXPLODER_OBELISK_FALL_2);
  level thread delayExploder(3, CONST_EXPLODER_OBELISK_FALL_3);

  showEnt(level.obeliskAnimated);
  showEnt(level.obeliskAnimated2);

  level.obeliskAnimated ScriptModelPlayAnimDeltaMotion("mp_dig_obelisk_dest_anim_01");
  level.obeliskAnimated2 ScriptModelPlayAnimDeltaMotion("mp_dig_obelisk_dest_anim_02");

  level.obeliskKillTrigger_Air thread delayTrigger(1, "on");
  level.obeliskKillTrigger_Air thread delayTrigger(2, "off");

  level thread obeliskImpact();

  level thread obeliskSounds();

  wait(CONST_OBELISK_FALL_ANIM_TIME);

  hideEnt(level.obeliskAnimated);
  hideEnt(level.obeliskAnimated2);
  showEnt(level.obeliskAfter);

  level.obeliskfallen = true;
}

resetObelisk() {
  while(true) {
    level waittill("obelisk_reset");

    if(level.obeliskfallen) {
      level.obeliskAfterClip ConnectPaths();

      if(level.gameType == "dom" || level.gameType == "siege") {
        updateBFlagPos(true);
        updateBFlagObjIcon();
      }

      level thread setupObelisk();
    }
  }
}

obeliskSounds() {
  level endon("game_ended");

  offsetBase = (0, 0, -300);
  offsetMid = (0, 0, 0);
  offsetHigh = (0, 0, 400);

  level.obeliskSoundBaseObj = spawn("script_model", level.obeliskAnimated.origin + offsetBase);
  level.obeliskSoundMidObj = spawn("script_model", level.obeliskAnimated.origin + offsetMid);
  level.obeliskSoundTopObj = spawn("script_model", level.obeliskAnimated.origin + offsetHigh);

  level.obeliskSoundBaseObj setModel("tag_origin");
  level.obeliskSoundMidObj setModel("tag_origin");
  level.obeliskSoundTopObj setModel("tag_origin");

  level.obeliskSoundMidObj Linkto(level.obeliskAnimated, "tag_mp_dig_obelisk_dyn_08");
  level.obeliskSoundTopObj Linkto(level.obeliskAnimated, "tag_mp_dig_obelisk_dyn_04");

  waitframe();

  level.obeliskSoundBaseObj playSound("mp_dig_obelisk_fall_base");
  level.obeliskSoundMidObj PlaySoundOnMovingEnt("mp_dig_obelisk_fall_mid");
  level.obeliskSoundTopObj PlaySoundOnMovingEnt("mp_dig_obelisk_fall_top");
}

obeliskImpact() {
  level endon("game_ended");

  earthquakeOrigin = (-1140, -108, 712);

  wait(CONST_OBELISK_IMPACT_TIME);

  Earthquake(0.4, 3, earthquakeOrigin, 2000);

  showEnt(level.obeliskAfterClip);
  level.obeliskAfterClip DisconnectPaths();

  showEnt(level.obeliskPathBlocker);
  level.obeliskPathBlocker ConnectPaths();
  level thread delayHide(level.obeliskPathBlocker, 0.05);

  if(level.gameType == "dom" || level.gameType == "siege") {
    updateBFlagPos();
    updateBFlagObjIcon();
  }

  level notify("obelisk_impact");
}

setupScarabPot(origin) {
  level endon("game_ended");

  breakablePot = spawn("script_model", origin);
  breakablePot setModel("dig_pottery_06");
  breakablePot.origin = origin;
  breakablePot.health = 300;
  breakablePot.damagetaken = 0;
  breakablePot.idleSound = "mp_dig_scarab_pot_rattle";
  breakablePot.lidSound = "mp_dig_scarab_pot_hit_lid";
  breakablePot.smokeSound = "mp_dig_scarab_pot_smoke_lp";
  breakablePot.breakSound = "mp_dig_scarab_pot_explode";
  breakablePot.hasScarabs = true;
  breakablePot.broken = false;
  breakablePot setCanDamage(true);
  breakablePot Solid(true);

  breakablePot thread playPotRattle();

  breakablePotLid = spawn("script_model", origin + (0, 0, 33));
  breakablePotLid setModel("dig_pottery_06_lid");

  level childthread resetScarabPot(breakablePot, origin);

  while(true) {
    breakablePot waittill("damage", amount, attacker, direction_vec, point, type);

    breakablePot.damagetype = type;
    breakablePot.damageOwner = attacker;

    breakablePot.damageTaken += amount;
    if(breakablePot.damageTaken == amount)
      breakablePot thread startPotBreaking(breakablePotLid);
  }
}

resetScarabPot(pot, origin) {
  while(true) {
    level waittill("scarab_pot_reset");

    if(!isDefined(pot)) {
      setupScarabPot(origin);
    }
  }
}

playPotRattle() {
  self endon("pot_lid_broken");
  level endon("game_ended");

  while(true) {
    if(isDefined(self))
      self playSound(self.idleSound);

    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(RandomIntRange(8, 15));
  }
}

startPotBreaking(breakablePotLid) {
  count = 0;
  startedfx = false;

  up = AnglesToUp(self.angles);
  worldup = AnglesToUp((0, 90, 0));
  dot = VectorDot(up, worldup);

  offset1 = (0, 0, 0);
  offset2 = (0, 0, 32);

  if(dot < 0.5) {
    offset1 = (up * 22) - (0, 0, 30);
    offset2 = (up * 22) + (0, 0, 14);
  }

  if(self.damagetype != "MOD_GRENADE_SPLASH" && self.damagetype != "MOD_GRENADE") {
    while(self.damageTaken < self.health) {
      if(!startedfx) {
        breakablePotLid Hide();
        self playSound(self.lidSound);

        self notify("pot_lid_broken");

        self thread playPotFX(offset2);
        self playLoopSound(self.smokeSound);

        startedfx = true;
      }
      if(count > 20)
        count = 0;

      if(count == 0) {
        self.damageTaken += (10 + RandomFloat(10));
      }
      count++;
      wait 0.05;
    }
  }

  self breakPot(breakablePotLid);
}

playPotFX(fxOrigin) {
  level endon("game_ended");

  while(isDefined(self) && !self.broken) {
    playFX(level.breakables_fx["scarabpot"]["break_top"], self.origin + fxOrigin);
    wait(0.1);
  }
}

breakPot(breakablePotLid) {
  breakablePotLid Hide();
  self playSound(self.lidSound);

  self notify("pot_lid_broken");
  self StopLoopSound(self.smokeSound);

  self.broken = true;
  self Solid(false);
  self setCanDamage(false);

  up = AnglesToUp(self.angles);
  worldup = AnglesToUp((0, 90, 0));
  dot = VectorDot(up, worldup);

  offset = (0, 0, 0);
  if(dot < 0.5) {
    start = (self.origin + (up * 22));
    end = PhysicsTrace(start, (start + (0, 0, -64)));
    offset = end - self.origin;
  }
  offset += (0, 0, 4);

  self playSound(self.breakSound);

  playFX(level.breakables_fx["scarabpot"]["break"], self.origin + offset + (0, 0, 20));
  playFX(level.breakables_fx["scarabpot"]["break_scarabs"], self.origin + offset + (0, 0, 30));

  self Hide();

  if(self.hasScarabs)
    self setupDeathZone();
}

setupDeathZone() {
  zoneRadius = 65;
  zoneHeight = 10;
  deathZone = spawn("trigger_radius", self.origin, 0, zoneRadius, zoneHeight);
  deathZone thread setupScarab(self.damageOwner);

  self Delete();
}

setupScarab(attacker) {
  level endon("game_ended");

  scarabLifeTime = 15;
  scarabMover = spawn("script_model", self.origin);
  scarabMover setModel("tag_origin");
  scarabMover.sound = "mp_dig_scarab_swarm";
  scarabMover.owner = attacker;
  scarabMover.killcamEnt = spawn("script_model", scarabMover.origin + (0, 0, 100));
  scarabMover.killcamEnt setModel("tag_origin");

  if(!isDefined(level.traps))
    level.traps = [];

  level.traps[level.traps.size] = scarabMover;

  scarabMover thread watchLifeTime("scarabs_death", "scarabs_attacked_player", scarabLifeTime);
  scarabMover thread cleanUpScarab(self);
  scarabMover thread playScarabFX();

  scarabMover playSound(scarabMover.sound);

  wait(CONST_SCARAB_APPEAR_TIME);

  scarabMover thread watchScarabTrigger(self);
}

cleanUpScarab(deathZone) {
  self waittill_any("scarabs_killed_player", "scarabs_death");

  level.traps = array_remove(level.traps, self);

  self Delete();
  deathZone Delete();
}

playScarabFX() {
  level endon("game_ended");

  waitframe();
  playFXOnTag(level.breakables_fx["scarab"]["ground"], self, "tag_origin");
  playFXOnTag(level.breakables_fx["scarab"]["flyers"], self, "tag_origin");
}

delayStopSound(delayTime) {
  level endon("game_ended");

  wait(delayTime);

  self StopSounds();
}

watchScarabTrigger(deathZone) {
  self endon("scarabs_death");

  while(true) {
    deathZone waittill("trigger", victim);

    if(level.teamBased) {
      if(isDefined(victim) && isPlayer(victim) && (victim.team != self.owner.team || victim == self.owner)) {
        self thread delayStopSound(0.5);
        self thread killNearbyVictim(victim);
        self notify("scarabs_attacked_player");
        break;
      }
    } else {
      if(isDefined(victim) && isPlayer(victim)) {
        self thread delayStopSound(0.5);
        self thread killNearbyVictim(victim);
        self notify("scarabs_attacked_player");
        break;
      }
    }
  }
}

killNearbyVictim(victim) {
  self endon("scarabs_killed_player");
  self endon("scarabs_death");

  self thread watchScarabKill(victim);

  if(isDefined(victim) && IsAlive(victim)) {
    stopFXOnTag(level.breakables_fx["scarab"]["flyers"], self, "tag_origin");
    self MoveTo(victim.origin, 0.8);
  }
}

watchScarabKill(victim, killImmediate) {
  victim endon("death");
  self endon("scarabs_killed_player");
  self endon("scarabs_death");

  if(!isDefined(killImmediate) || killImmediate == false) {
    while(DistanceSquared(victim.origin, self.origin) > CONST_SCARAB_KILL_RADIUS_SQUARED) {
      wait(0.05);
    }

    stopFXOnTag(level.breakables_fx["scarab"]["ground"], self, "tag_origin");
  }

  scarab_effect_ent = undefined;
  if(!victim isUsingRemote()) {
    scarab_effect_ent = SpawnFXForClient(level.breakables_fx["scarab"]["screen"], victim getEye(), victim);
    TriggerFX(scarab_effect_ent);
    scarab_effect_ent setfxkilldefondelete();
    victim PlayLocalSound("mp_dig_scarab_plr_overtaken");
  }

  victim PlaySoundOnMovingEnt("mp_dig_scarab_npc_overtaken");

  victim thread killFXOnPlayerDeath(scarab_effect_ent);
  victim thread doPeriodicDamage(scarab_effect_ent, CONST_SCARAB_DMG_TICK, CONST_SCARAB_DMG_INTERVAL, "MOD_SCARAB", self, "scarabs_killed_player", self.owner, self);
}

playCustomDeathSound(victim, sMeansofDeath, eInflictor) {
  if(sMeansofDeath == "MOD_SCARAB") {} else
    victim playDeathSound();
}

playDeathAnimScarabs() {
  level endon("game_ended");

  self waittill("death_delay_start");

  deathAnim = self.body getCorpseAnim();
  deathAnimModel = spawn("script_model", self.body.origin);
  deathAnimModel setModel("scarab_fullbody_bone_fx");
  deathAnimModel.origin = self.body.origin;
  deathAnimModel.angles = self.body.angles;
  deathAnimModel LinkTo(self.body, "tag_origin", (0, 50, 0), deathAnimModel.angles);

  if(deathAnim == % mp_scarab_death_stand_1)
    deathAnimModel ScriptModelPlayAnim("scarab_fullbody_bone_fx_stand_anim");
  else if(deathAnim == % mp_scarab_death_crouch_1)
    deathAnimModel ScriptModelPlayAnim("scarab_fullbody_bone_fx_crouch_anim");
  else
    deathAnimModel ScriptModelPlayAnim("scarab_fullbody_bone_fx_prone_anim");

  for(index = 0; index < CONST_MAX_SCARAB_DEATH_BONES; index++) {
    if(index < 2)
      continue;
    else if(index < 10)
      playFXOnTag(level.dig_fx["scarab"]["deathAnim"], deathAnimModel, "Point00" + index);
    else
      playFXOnTag(level.dig_fx["scarab"]["deathAnim"], deathAnimModel, "Point0" + index);

    waitframe();
  }

  self thread stopFXOnPlayerspawn(deathAnimModel);
}

stopFXOnPlayerspawn(model) {
  level endon("game_ended");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(CONST_SCARAB_FALLOFF_TIME);

  for(index = 0; index < CONST_MAX_SCARAB_DEATH_BONES; index++) {
    if(index < 2)
      continue;
    else if(index < 10)
      stopFXOnTag(level.dig_fx["scarab"]["deathAnim"], model, "Point00" + index);
    else
      stopFXOnTag(level.dig_fx["scarab"]["deathAnim"], model, "Point0" + index);

    waitframe();
  }

  model delete();
}

setupRadio() {
  level endon("game_ended");

  level.treasure_room_jackpot = false;

  level.radioArray = getEntArray("secret_room_radio", "targetname");

  jackPotStartTime = RandomIntRange(2, 5);
  radioLoopTime = RandomIntRange(30, 60);

  level thread jackpotWatcher(jackPotStartTime, radioLoopTime);
}

jackpotWatcher(jackPotStartTime, radioLoopTime) {
  level endon("game_ended");

  while(true) {
    if(getMinutesPassed() > jackPotStartTime && (isDefined(level.treasure_room_jackpot) && !level.treasure_room_jackpot)) {
      foreach(radio in level.radioArray) {
        if(isDefined(radio))
          radio playSound("mp_dig_uk_tomb_special");
      }

      level thread jackpotTimeout(CONST_CHEST_JACKPOT_LENGTH);

      level.treasure_room_jackpot = true;
    } else {
      foreach(radio in level.radioArray) {
        if(isDefined(radio))
          radio playSound("mp_dig_uk_tomb1");
      }
    }

    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(radioLoopTime);
  }
}

jackpotTimeout(jackpotLength) {
  level endon("game_ended");
  level endon("chest_raided");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(jackpotLength);

  level.treasure_room_jackpot = undefined;
}

setupTreasureRoom() {
  level.treasure_room_open = false;

  level.treasureDoor = GetEnt("secret_room_door_model", "targetname");
  level.treasureDoorClip = GetEnt("secret_room_door", "targetname");

  if(isDefined(level.treasureDoor) && isDefined(level.treasureDoorClip))
    level.treasureDoorClip LinkTo(level.treasureDoor);

  level.flameDeathZone = GetEnt("secret_room_kill", "targetname");

  if(isDefined(level.flameDeathZone)) {
    level.flameDeathZone.dmg = 0;
    level.flameDeathZone thread killAll("flame_ended", 5000, "MOD_CRUSH");
    level.flameDeathZone trigger_off();
  }

  level thread watchTorchesUsed();

  level.key_torches = getEntArray("torch_trigs", "targetname");

  foreach(torch in level.key_torches) {
    torch SetHintString(&"MP_DIG_ACTIVATE_TORCH");
    torch thread watchTorchUse();
    torch.used = false;
  }
}

watchTorchUse() {
  level endon("game_ended");

  self waittill("trigger", player);

  self activateTorch(player);
}

activateTorch(player) {
  self MakeUnusable();

  torch = GetEnt(self.target, "targetname");
  torch RotatePitch(-45, 4);

  torch playSound("mp_dig_torch_rotate");

  torchRotateFX = SpawnFx(level.dig_fx["torch"]["sand"], torch.origin);
  TriggerFX(torchRotateFX);

  self.used = true;

  level notify("torch_used", player);
}

watchTorchesUsed() {
  level endon("game_ended");

  torchesUsed = 0;

  while(true) {
    level waittill("torch_used", player);
    torchesUsed += 1;

    if(torchesUsed == 3) {
      level.dig_hidden_door_owner = player;
      level thread openTreasureRoom();
      torchesUsed = 0;
    }
  }
}

openTreasureRoom() {
  level endon("game_ended");

  offset = (-5, -105, 0);

  if(!isDefined(level.doorSoundObj)) {
    level.doorSoundObj = spawn("script_model", level.treasureDoor.origin + offset);
    level.doorSoundObj setModel("tag_origin");
    level.doorSoundObj LinkTo(level.treasureDoor);
  }

  level thread doorSounds();

  level.treasureDoor RotateYaw(75, CONST_DOOR_MOVE_TIME);

  Earthquake(0.1, CONST_DOOR_MOVE_TIME, level.treasureDoor.origin, 500);

  exploder(CONST_EXPLODER_CHEST_DOOR);

  wait(CONST_DOOR_MOVE_TIME);

  level.treasureDoorClip ConnectPaths();

  level.treasure_room_open = true;

  spawnKillstreakChest();

  level thread resetTreasureRoom();
}

doorSounds() {
  level endon("game_ended");

  waitframe();

  level.doorSoundObj PlaySoundOnMovingEnt("mp_dig_treasure_door_open");
}

spawnKillstreakChest() {
  level.chest_rewardType = random(["uplink_support", "deployable_vest", "deployable_ammo", "ball_drone_radar", "aa_launcher", "jammer", "ims"]);

  if(isDefined(level.treasure_room_jackpot) && level.treasure_room_jackpot)
    level.chest_rewardType = "odin_assault";

  level.chest_rewardHint = game["strings"][level.chest_rewardType + "_hint"];

  if(!isDefined(level.chest_trigger))
    level.chest_trigger = GetEnt("secret_room_chest", "targetname");

  if(isDefined(level.chest_trigger)) {
    if(!isDefined(level.chest_useObj)) {
      level.chest_useObj = maps\mp\gametypes\_gameobjects::createUseObject("neutral", level.chest_trigger, [level.chest_trigger], (0, 0, 0));
      level.chest_useObj.id = "care_package";
    } else {
      level.chest_useObj maps\mp\gametypes\_gameobjects::enableObject();
    }

    level.chest_useObj maps\mp\gametypes\_gameobjects::setUseTime(CONST_CHEST_USE_TIME);
    level.chest_useObj maps\mp\gametypes\_gameobjects::setUseHintText(level.chest_rewardHint);
    level.chest_useObj maps\mp\gametypes\_gameobjects::setVisibleTeam("any");
    level.chest_useObj maps\mp\gametypes\_gameobjects::allowUse("any");

    level.chest_useObj.onUse = ::chestOnUse;
    level.chest_useObj.onBeginUse = ::chestOnBeginUse;
    level.chest_useObj.onEndUse = ::chestOnEndUse;

    if(!isDefined(level.chest_display))
      level.chest_display = getStruct(level.chest_trigger.target, "targetname");

    level.chest_display maps\mp\_entityheadIcons::setHeadIcon(level.dig_hidden_door_owner, getKillstreakOverheadIcon(level.chest_rewardType), (0, 0, 0), 14, 14, false, undefined, undefined, undefined, undefined, false);
  }
}

chestOnUse(player) {
  player chestUpdate();

  self maps\mp\gametypes\_gameobjects::disableObject();
}

chestOnBeginUse(player) {}

chestOnEndUse(team, player, result) {
  if(isPlayer(player)) {
    player maps\mp\gametypes\_gameobjects::updateUIProgress(self, false);
  }
}

chestUpdate() {
  level.chest_display maps\mp\_entityheadIcons::setHeadIcon(level.dig_hidden_door_owner, "", (0, 0, 10), 14, 14, false, undefined, undefined, undefined, undefined, false);

  exploder(CONST_EXPLODER_CHEST_SMOKE);
  level.chest_trigger playSound("mp_dig_treasure_smoke");

  offset = (120, 70, -50);
  earthquakePoint = spawn("script_origin", level.chest_trigger.origin + offset);
  earthquakePoint Hide();

  Earthquake(0.2, CONST_DOOR_MOVE_TIME + 1, earthquakePoint.origin, 400);
  earthquakePoint playSound("mp_dig_door_rumble");

  self thread maps\mp\killstreaks\_killstreaks::giveKillstreak(level.chest_rewardType, false, false, self);

  if(isDefined(level.treasure_room_jackpot) && level.treasure_room_jackpot) {
    level.treasure_room_jackpot = undefined;
    level notify("chest_raided");
  }

  level thread notifyDeadPlayers();
  level thread closeTreasureRoom();
}

resetTreasureRoom() {
  level endon("game_ended");

  level waittill("treasure_room_reset");

  if(level.treasure_room_open)
    level thread closeTreasureRoom();

  level.chest_display maps\mp\_entityheadIcons::setHeadIcon(level.dig_hidden_door_owner, "", (0, 0, 10), 14, 14, false, undefined, undefined, undefined, undefined, false);

  if(isDefined(level.chest_useObj))
    level.chest_useObj maps\mp\gametypes\_gameobjects::disableObject();

  foreach(torch in level.key_torches) {
    if(torch.used) {
      torchModel = GetEnt(torch.target, "targetname");
      torchModel RotatePitch(45, 0.1);

      torch MakeUsable();
      torch SetHintString(&"MP_DIG_ACTIVATE_TORCH");
      torch thread watchTorchUse();
      torch.used = false;
    }
  }

  level.treasure_room_jackpot = false;
}

notifyDeadPlayers() {
  level endon("game_ended");

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(CONST_DOOR_MOVE_TIME - 4);

  level.flameDeathZone trigger_on();

  foreach(player in level.players) {
    if(player IsTouching(level.flameDeathZone))
      player PlayLocalSound("mp_dig_tomb_die1");
  }
}

closeTreasureRoom() {
  level endon("game_ended");

  if(isDefined(level.doorSoundObj))
    level.doorSoundObj PlaySoundOnMovingEnt("mp_dig_treasure_door_close");

  level.treasureDoor RotateYaw(-75, CONST_DOOR_MOVE_TIME);

  Earthquake(0.1, CONST_DOOR_MOVE_TIME, level.treasureDoor.origin, 500);

  maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(CONST_DOOR_MOVE_TIME);

  level.treasureDoorClip DisconnectPaths();

  level.treasure_room_open = false;

  level thread triggerFlameTrap();
}

triggerFlameTrap() {
  exploder(CONST_EXPLODER_CHEST_FLAMES);

  flameCenterPipes = getStructArray("secret_room_fire_mid", "targetname");

  foreach(index, pipe in flameCenterPipes) {
    fireSoundObj = spawn("script_origin", pipe.origin);
    fireSoundObj Hide();
    fireSoundObj playSound("mp_dig_fire_wall" + (index + 1));
  }

  foreach(player in level.participants) {
    if(isPlayer(player) && isReallyAlive(player) && player IsTouching(level.flameDeathZone)) {
      playFXOnTag(level.dig_fx["flametrap"]["player"], player, "j_spineupper");

      fire_effect_ent = SpawnFXForClient(level.dig_fx["flametrap"]["screen"], player getEye(), player);
      TriggerFX(fire_effect_ent);
      fire_effect_ent setfxkilldefondelete();

      player thread killFXOnPlayerDeath(fire_effect_ent);
      player thread stopFXOnspawn(level.dig_fx["flametrap"]["player"], "j_spineupper");
      player thread doPeriodicDamage(fire_effect_ent, CONST_FLAME_DMG_TICK, CONST_FLAME_DMG_INTERVAL, "MOD_SCARAB");
    }
  }

  level thread delayNotify("flame_ended", 4);
}

setupSnakes(origin) {
  level endon("game_ended");

  if(!isDefined(level.dig_snake)) {
    level.dig_snake = spawn("script_model", origin);
    level.dig_snake setModel("snake_many_mp_dig_secretroom");
    level.dig_snake.origin = origin;
  }

  while(true) {
    level.dig_snake ScriptModelPlayAnim("snake_many_mp_dig_secretroom_anim");
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause(CONST_SNAKE_ANIM_LENGTH);
  }
}

setupShrinePerks() {
  level.shrinePerks = [];

  level.abilityCategories = maps\mp\gametypes\_class::getNumAbilityCategories();
  level.abilityPerCategory = maps\mp\gametypes\_class::getNumSubAbility();

  for(abilityCategoryIndex = 0; abilityCategoryIndex < level.abilityCategories; abilityCategoryIndex++) {
    for(abilityIndex = 0; abilityIndex < level.abilityPerCategory; abilityIndex++) {
      perkName = TableLookup("mp/cacAbilityTable.csv", 0, abilityCategoryIndex + 1, 4 + abilityIndex);

      if(validShrinePerk(perkName))
        level.shrinePerks[level.shrinePerks.size] = perkName;
    }
  }
}

validShrinePerk(perkName) {
  validPerk = true;

  switch (perkName) {
    case "specialty_extra_equipment":
    case "specialty_extra_deadly":
    case "specialty_extraammo":
    case "specialty_extra_attachment":
    case "specialty_gambler":
    case "specialty_hardline":
    case "specialty_twoprimaries":
      validPerk = false;
      break;
  }

  return validPerk;
}

DIG_LEVEL_KILLSTREAK_WEIGHT = 85;

digCustomCrateFunc() {
  if(!isDefined(game["player_holding_level_killstrek"]))
    game["player_holding_level_killstrek"] = false;

  if(!allowLevelKillstreaks() || game["player_holding_level_killstrek"] || !level.allow_level_killstreak) {
    return;
  }
  maps\mp\killstreaks\_airdrop::addCrateType("airdrop_assault", "dig_level_killstreak", DIG_LEVEL_KILLSTREAK_WEIGHT, ::digCrateThink, maps\mp\killstreaks\_airdrop::get_friendly_crate_model(), maps\mp\killstreaks\_airdrop::get_enemy_crate_model(), &"MP_DIG_ACTIVATE_SHRINE");
  maps\mp\killstreaks\_airdrop::generateMaxWeightedCrateValue();
  level thread watch_for_dig_killstreak();
}

digCrateThink(dropType) {
  self endon("death");
  self endon("restarting_physics");
  level endon("game_ended");

  if(isDefined(game["strings"][self.crateType + "_hint"]))
    crateHint = game["strings"][self.crateType + "_hint"];
  else

    crateHint = &"PLATFORM_GET_KILLSTREAK";

  maps\mp\killstreaks\_airdrop::crateSetupForUse(crateHint, getKillstreakOverheadIcon(self.crateType));

  self thread crateOtherCaptureThink();
  self thread crateOwnerCaptureThink();

  while(true) {
    self waittill("captured", player);

    level.dig_killstreak_user = player;

    if(isPlayer(player)) {
      player SetClientOmnvar("ui_securing", 0);
      player.ui_securing = undefined;
    }

    tryUseDigKillstreak();

    self maps\mp\killstreaks\_airdrop::deleteCrate();
  }
}

crateOtherCaptureThink(useText) {
  self endon("restarting_physics");

  while(isDefined(self)) {
    self waittill("trigger", player);

    if(isDefined(self.owner) && player == self.owner) {
      continue;
    }
    if(!self maps\mp\killstreaks\_airdrop::validateOpenConditions(player)) {
      continue;
    }
    if(player isJuggernaut()) {
      player IPrintLnBold(&"MP_DIG_LEVEL_KILLSTREAK_REJECT");
    } else {
      if(isDefined(level.overrideCrateUseTime))
        useTime = level.overrideCrateUseTime;
      else
        useTime = undefined;

      player.isCapturingCrate = true;
      useEnt = self maps\mp\killstreaks\_airdrop::createUseEnt();
      result = useEnt maps\mp\killstreaks\_airdrop::useHoldThink(player, useTime, useText);

      if(isDefined(useEnt))
        useEnt delete();

      if(!isDefined(player)) {
        return;
      }
      if(!result) {
        player.isCapturingCrate = false;
        continue;
      }

      player.isCapturingCrate = false;
      self notify("captured", player);
    }
  }
}

crateOwnerCaptureThink(useText) {
  self endon("restarting_physics");

  while(isDefined(self)) {
    self waittill("trigger", player);

    if(isDefined(self.owner) && player != self.owner) {
      continue;
    }
    if(!self maps\mp\killstreaks\_airdrop::validateOpenConditions(player)) {
      continue;
    }
    if(player isJuggernaut()) {
      player IPrintLnBold(&"MP_DIG_LEVEL_KILLSTREAK_REJECT");
    } else {
      player.isCapturingCrate = true;
      if(!maps\mp\killstreaks\_airdrop::useHoldThink(player, 500, useText)) {
        player.isCapturingCrate = false;
        continue;
      }

      player.isCapturingCrate = false;
      self notify("captured", player);
    }
  }
}

watch_for_dig_killstreak() {
  while(true) {
    level waittill("createAirDropCrate", dropCrate);

    if(isDefined(dropCrate) && isDefined(dropCrate.crateType) && dropCrate.crateType == "dig_level_killstreak") {
      disable_level_killstreak();
      captured = wait_for_capture(dropCrate);

      if(!captured) {
        enable_level_killstreak();
      } else {
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

enable_level_killstreak() {
  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "dig_level_killstreak", DIG_LEVEL_KILLSTREAK_WEIGHT);
  level.intelRewardOverride = "dig_level_killstreak";
}

disable_level_killstreak() {
  maps\mp\killstreaks\_airdrop::changeCrateWeight("airdrop_assault", "dig_level_killstreak", 0);
  level.intelRewardOverride = undefined;
}

digCustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/Dig Killstreak\" \"set scr_devgivecarepackage dig_level_killstreak; set scr_devgivecarepackagetype airdrop_assault\"\n");
  level.killStreakFuncs["dig_level_killstreak"] = ::tryUseDigKillstreak;
}

digCustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/Dig Killstreak\" \"set scr_testclients_givekillstreak dig_level_killstreak\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func("dig_level_killstreak", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

tryUseDigKillstreak(lifeId, streakName) {
  level.dig_killstreak_user givePerkBonus();

  level.dig_killstreak_user thread watchPerkBlessing();

  level.dig_killstreak_user thread watchJuggUse();

  level.dig_killstreak_user thread watchRemoteUse("using_remote");
  level.dig_killstreak_user thread watchRemoteUse("stopped_using_remote");

  if(level.gameType == "blitz")
    level.dig_killstreak_user thread watchBlitzTeleport();

  level thread watchPlayersConnect(level.dig_killstreak_user);

  level thread watchBlessingEnd(level.dig_killstreak_user);

  level thread teamPlayerCardSplash("used_dig_level_killstreak", level.dig_killstreak_user);
}

givePerkBonus() {
  if(!isDefined(level.player_life_counter))
    level.player_life_counter = 0;

  foreach(perk in level.shrinePerks) {
    if(!self _hasPerk(perk))
      self givePerk(perk, false);
  }

  self thread maps\mp\gametypes\_hud_message::SplashNotify("mp_dig_all_perks");

  level thread showBlessingFX(self);
  self thread stopFXOnspawn(level.dig_fx["shrine"]["player"], "tag_origin");

  if(!isDefined(self.shrine_effect_ent)) {
    self.shrine_effect_ent = SpawnFXForClient(level.dig_fx["shrine"]["screen"], self getEye(), self);
    TriggerFX(self.shrine_effect_ent);
    self.shrine_effect_ent setfxkilldefondelete();
    self thread killFXOnPlayerDeath(self.shrine_effect_ent, "reset_perk_bonus", "user_juggernaut", "user_remotekillstreak");
  }

  self PlayLocalSound("mp_dig_plr_spawn_with_powers");
  self playLoopSound("mp_dig_magic_powers_flame_lp");

  level notify("update_bombsquad");

  level.player_life_counter += 1;
}

resetPerkBonus() {
  level.player_life_counter = 0;

  self SetClientOmnvar("ui_dig_killstreak_show", -1);

  stopFXOnTag(level.dig_fx["shrine"]["player"], self, "tag_origin");

  if(isDefined(self.shrine_effect_ent))
    self.shrine_effect_ent delete();

  level notify("reset_perk_bonus");
}

watchPerkBlessing() {
  self endon("disconnect");
  self endon("blessing_ended");
  self endon("joined_team");
  level endon("game_ended");

  while(true) {
    self waittill("spawned_player");

    self SetClientOmnvar("ui_dig_killstreak_show", -1);

    waitframe();

    if(level.player_life_counter < 4 && !self isJuggernaut()) {
      self givePerkBonus();

      if(!self hasPerkInLoadout("specialty_blindeye") || !self hasPerkInLoadout("specialty_gpsjammer"))
        self childthread reGiveSpawnPerks();
    } else if(level.player_life_counter == 4)
      self notify("blessing_ended");
  }
}

hasPerkInLoadout(checkPerk) {
  existingPerk = false;

  if(isDefined(self.pers["loadoutPerks"]) && self.pers["loadoutPerks"].size > 0) {
    foreach(perk in self.pers["loadoutPerks"]) {
      if(checkPerk == perk) {
        existingPerk = true;
        break;
      }
    }
  }

  return existingPerk;
}

reGiveSpawnPerks() {
  self waittill("starting_perks_unset");

  if(!self _hasPerk("specialty_blindeye"))
    self givePerk("specialty_blindeye", false);

  if(!self _hasPerk("specialty_gpsjammer"))
    self givePerk("specialty_gpsjammer", false);
}

watchJuggUse() {
  self endon("disconnect");
  self endon("blessing_ended");
  self endon("joined_team");
  level endon("game_ended");

  while(true) {
    level waittill("juggernaut_equipped", player);

    if(self == player) {
      self.shrine_effect_ent delete();
      stopFXOnTag(level.dig_fx["shrine"]["player"], self, "tag_origin");
      level notify("user_juggernaut");
    }
  }
}

watchRemoteUse(notifyMSG) {
  self endon("disconnect");
  self endon("blessing_ended");
  self endon("joined_team");
  level endon("game_ended");

  while(true) {
    self waittill(notifyMSG);

    if(notifyMSG == "using_remote") {
      if(isDefined(self.shrine_effect_ent)) {
        self.shrine_effect_ent delete();
        level notify("user_remotekillstreak");
      }
    } else if(notifyMSG == "stopped_using_remote") {
      if(!isDefined(self.shrine_effect_ent)) {
        self.shrine_effect_ent = SpawnFXForClient(level.dig_fx["shrine"]["screen"], self getEye(), self);
        TriggerFX(self.shrine_effect_ent);
        self.shrine_effect_ent setfxkilldefondelete();
        self thread killFXOnPlayerDeath(self.shrine_effect_ent, "reset_perk_bonus", "user_juggernaut", "user_remotekillstreak");
      }
    }
  }
}

watchBlitzTeleport() {
  self endon("disconnect");
  self endon("blessing_ended");
  self endon("joined_team");
  level endon("game_ended");

  while(true) {
    level waittill("portal_used", team);

    waitframe();

    if(team != self.team && (isDefined(self.teleporting) && self.teleporting)) {
      level thread showBlessingFX(self);
    }
  }
}

watchPlayersConnect(blessingUser) {
  blessingUser endon("disconnect");
  blessingUser endon("blessing_ended");
  blessingUser endon("joined_team");
  level endon("game_ended");

  while(true) {
    level waittill("connected", player);

    player thread playFXOnPlayerspawn(blessingUser);
  }
}

watchBlessingEnd(blessingUser) {
  level endon("game_ended");

  blessingUser waittill_any("disconnect", "joined_team", "blessing_ended");

  level.player_life_counter = 0;
}

showBlessingFX(blessingUser) {
  blessingUser endon("disconnect");
  blessingUser endon("blessing_ended");
  blessingUser endon("joined_team");
  level endon("game_ended");

  foreach(player in level.players) {
    if(isDefined(player) && isDefined(blessingUser) && IsReallyAlive(blessingUser))
      PlayFXOnTagForClients(level.dig_fx["shrine"]["player"], blessingUser, "tag_origin", player);

    waitframe();
  }
}

playFXOnPlayerspawn(blessingUser) {
  blessingUser endon("disconnect");
  blessingUser endon("blessing_ended");
  blessingUser endon("joined_team");
  level endon("game_ended");

  self waittill("spawned_player");

  if(isDefined(self) && isDefined(blessingUser) && IsReallyAlive(blessingUser))
    PlayFXOnTagForClients(level.dig_fx["shrine"]["player"], blessingUser, "tag_origin", self);
}

watchLifeTime(sendNotify, endonNotify, lifeTime) {
  self endon(endonNotify);

  while(lifeTime > 0) {
    lifeTime -= 1;
    wait(1);
  }

  self notify(sendNotify);
}

doPeriodicDamage(screenEffect, damage, interval, damageType, notifyObject, notifyMsg, owner, source) {
  level endon("game_ended");

  if(!isDefined(damageType))
    damageType = "MOD_CRUSH";

  hasPlayedDeathSound = false;

  attacker = undefined;
  inflictor = undefined;

  if(isDefined(owner) && isDefined(source)) {
    attacker = owner;
    inflictor = source;
  }

  while(IsReallyAlive(self)) {
    self DoDamage(damage, self.origin, attacker, inflictor, damageType);

    if(damageType == "MOD_SCARAB") {
      if(self.health <= 30 && !hasPlayedDeathSound) {
        rand = RandomIntRange(1, 8);

        type = "male";
        if(self hasFemaleCustomizationModel())
          type = "female";

        if(self.team == "axis")
          self playSound(type + "_scarab_death_russian" + rand);
        else
          self playSound(type + "_scarab_death_american" + rand);

        hasPlayedDeathSound = true;
      }
    }

    wait(interval);
  }

  if(isDefined(notifyObject) && isDefined(notifyMsg))
    notifyObject notify(notifyMsg);
}

killFXOnPlayerDeath(effect, endonMSG, endonMSG2, endonMSG3) {
  level endon("game_ended");

  if(isDefined(endonMSG))
    level endon(endonMSG);

  if(isDefined(endonMSG2))
    level endon(endonMSG2);

  if(isDefined(endonMSG3))
    level endon(endonMSG3);

  self waittill_any("killed_player", "disconnect");

  if(isDefined(effect)) {
    if(IsArray(effect)) {
      foreach(fx in effect) {
        fx delete();
      }
    } else
      effect delete();
  }
}

stopFXOnspawn(effect, tag) {
  level endon("game_ended");

  self waittill("spawned_player");

  stopFXOnTag(effect, self, tag);
}

drawLinkedSphere(radius, length, singleShot) {
  level endon("game_ended");

  previousPosition = (0, 0, 0);

  while(true) {
    if(previousPosition != self.origin) {
      Sphere(self.origin, radius, (255, 255, 255), false, int(length * 30));
      previousPosition = self.origin;

      if(isDefined(singleShot) && singleShot) {
        break;
      }
    }

    waitframe();
  }
}

getFirstAlivePlayer() {
  foreach(player in level.participants) {
    if(isDefined(player) && isReallyAlive(player))
      return player;
  }
}

delayHide(ent, time) {
  level endon("game_ended");

  wait(time);

  ent Hide();
  ent NotSolid();
}

killAll(waitNotify, damage, meansOfDeath) {
  level endon("game_ended");

  level waittill(waitNotify);

  if(isDefined(self.trigger_off))
    self trigger_on();

  waitframe();

  attacker = getAttacker(waitNotify);
  inflictor = getInflictor(waitNotify);

  self killAllTouchingTrigger(level.characters, CONST_CHARACTERS, damage, meansOfDeath, attacker, inflictor);

  self killAllTouchingTrigger(level.turrets, CONST_KILLSTREAKS, damage, meansOfDeath, attacker, inflictor);

  self killAllTouchingTrigger(level.placedIMS, CONST_KILLSTREAKS, damage, meansOfDeath, attacker, inflictor);

  self killAllTouchingTrigger(level.ballDrones, CONST_KILLSTREAKS, damage, meansOfDeath, attacker, inflictor);

  self killAllTouchingTrigger(level.uplinks, CONST_KILLSTREAKS, damage, meansOfDeath, attacker, inflictor);

  self killAllTouchingTrigger(level.remote_uav, CONST_KILLSTREAKS, damage, meansOfDeath, attacker, inflictor);

  boxes = [];
  script_models = getEntArray("script_model", "classname");
  foreach(mod in script_models) {
    if(isDefined(mod.boxtype)) {
      boxes[boxes.size] = mod;
    }
  }

  self killAllTouchingTrigger(boxes, CONST_KILLSTREAKS, damage, meansOfDeath, attacker, inflictor);

  self killAllTouchingTrigger(level.mines, CONST_EQUIPMENT, damage, meansOfDeath, attacker, inflictor);

  if(level.gametype == "sd" || level.gametype == "sr") {
    if(isDefined(level.sdBomb) && level.sdBomb.visuals[0] IsTouching(self)) {
      level.sdBomb notify("stop_pickup_timeout");
      level.sdBomb maps\mp\gametypes\_gameobjects::returnHome();
    }
  }

  foreach(package in level.carePackages) {
    if(package.friendlyModel IsTouching(self) || package.enemyModel IsTouching(self))
      package maps\mp\killstreaks\_airdrop::deleteCrate();
  }

  if(isDefined(level.intelEnt)) {
    if(level.intelEnt["visuals"] IsTouching(self))
      level.intelEnt["dropped_time"] = -60000;
  }

  level thread activateKillTrigger(self, damage);
}

killAllTouchingTrigger(entArray, type, damage, meansOfDeath, attacker, inflictor) {
  foreach(ent in entArray) {
    if(isDefined(ent) && ent IsTouching(self)) {
      switch (type) {
        case CONST_CHARACTERS:

          if(IsAgent(ent) && isDefined(ent.team) && ent.team == attacker.team)
            ent DoDamage(damage, ent.origin, undefined, inflictor, meansOfDeath);
          else
            ent DoDamage(damage, ent.origin, attacker, inflictor, meansOfDeath);
          break;
        case CONST_KILLSTREAKS:
        case CONST_EQUIPMENT:
          ent destroyKillstreak(damage, meansOfDeath, attacker);
          break;
      }
    }
  }
}

destroyKillstreak(damage, meansOfDeath, attacker) {
  direction_vec = (0, 0, 0);
  point = (0, 0, 0);
  modelName = "";
  tagName = "";
  partName = "";
  iDFlags = undefined;
  weaponName = "killstreak_emp_mp";

  self notify("damage", damage, attacker, direction_vec, point, meansOfDeath, modelName, tagName, partName, iDFlags, weaponName);
}

activateKillTrigger(trigger, damage) {
  level endon("game_ended");

  if(isDefined(trigger)) {
    trigger.dmg = damage;

    waitframe();

    trigger.dmg = 0;
    trigger trigger_off();
  }
}

delayNotify(notifyMsg, delayTime) {
  level endon("game_ended");

  wait(delayTime);

  level notify(notifyMsg);
}

showEnt(ent) {
  ent Show();
  ent Solid();
}

hideEnt(ent) {
  ent Hide();
  ent NotSolid();
}

getAttacker(waitNotify) {
  attacker = undefined;

  switch (waitNotify) {
    case "obelisk_impact":
      attacker = level.obeliskOwner;
      break;
    case "flame_ended":
      attacker = level.dig_hidden_door_owner;
      break;
  }

  return attacker;
}

getInflictor(waitNotify) {
  inflictor = undefined;

  switch (waitNotify) {
    case "obelisk_impact":
      inflictor = level.obeliskAfterClip;
      break;
    case "flame_ended":
      inflictor = level.treasureDoorClip;
      break;
  }

  return inflictor;
}

nuke_custom_visionset() {
  level waittill("nuke_death");

  wait 1.3;

  level notify("nuke_death");
  thread nuke_custom_visionset();
}

nukeDeathVision() {
  level.nukeVisionSet = "aftermath_mp_dig";
  setExpFog(512, 2048, 0.578828, 0.802656, 1, 0.5, 0.75, 5, 0.382813, 0.350569, 0.293091, .5, (1, -0.109979, 0.267867), 0, 80, 1, 0.179688, 26, 180);
  VisionSetNaked(level.nukeVisionSet, 5);
  VisionSetPain(level.nukeVisionSet);
}

delayExploder(time, exploderID) {
  level endon("game_ended");

  wait(time);

  exploder(exploderID);
}

delayTrigger(time, state) {
  level endon("game_ended");

  wait(time);

  if(state == "on")
    self trigger_on();
  else
    self trigger_off();
}