/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\opaque\58315.gsc
***********************************************/

function bot_allowed_to_try_last_loadout() {
  level endon("game_ended");
  waitframe();
  scripts\mp\flags::gameflagwait("prematch_done");
  level.are_all_hvts_eliminated = [];
  level.next_drone_cd = &next_drone_cd;
  level.arena_bot_get_total_gun_ammo = getEntArray("br_ai_spawn_trigger", "targetname");
  scripts\engine\utility::array_thread(level.arena_bot_get_total_gun_ammo, &bot_affirm);
  level.spawnziptie = getdvarint("scr_default_maxagents", 15);
}

function bot_affirm() {
  level endon("game_ended");
  var0 = self;

  for(;;) {
    var0 waittill("trigger", var1);

    if(isagent(var1)) {
      continue;
    }

    break;
  }

  var2 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  var3 = [];

  foreach(var5 in var2) {
      if(level.are_all_hvts_eliminated.size >= level.spawnziptie) {
        break;
      }

      if(getdvarint("scr_br_ai_parachuteSpawn", 0) == 1 && istrue(var5.„ù¸ ? ¯ã + Ã† fû› û {
            NëKpÐã - {
            )) {
            var6 = thread _testing_ending::spawnnewparachuteagent(var5.origin, var5.angles, 1, "actor_enemy_lw_br_german_african");
          } else {
            var6 = thread _testing_ending::spawnnewagent(var5.origin, var5.angles, 1, "actor_enemy_lw_br_german_african");
          }

          level.are_all_hvts_eliminated = scripts\engine\utility::array_add(level.are_all_hvts_eliminated, var6);

          if(isDefined(var5.script_noteworthy)) {
            var6.script_noteworthy = var5.script_noteworthy;
          }

          bot_capture_koth_zone(var6); bomb_detonator_bomb_type(var6); var3 = scripts\engine\utility::array_add(var3, var6); var7 = getEnt(var5.target, "targetname");

          if(!isDefined(var7)) {
            continue;
          }

          if(isDefined(var6.script_noteworthy) && var6.script_noteworthy == "delay_goal_volume") {
            blueprintcreatingteam(var6, var7);
          } else {
            var6 setgoalvolumeauto(var7);

            if(isPlayer(var1)) {
              var6 agentsetfavoriteenemy(var1);
              var6 getenemyinfo(var1);
            }
          }

          if(isDefined(level.ref_11ffd) && isbuiltinfunction(level.ref_11ffd)) {
            [[level.ref_11ffd]](var6, var0);
          }
        }
      }

      function bot_capture_koth_zone() {
        self.guid = self getguid();
        self.name = self.guid;
        self.agentname = &"BR_SOA_EVENT/HENCHMAN";
        self.goalradius = randomintrange(100, 200);
        self.scripted_long_deaths = 0;
        self.agentdamagefeedback = 1;
        _testing_ending::ref_13122(0.5);
        _testing_ending::ref_13123(30);
        scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349f("gas_grenade_mp", 2);
        thread boss_wave();
        thread bot_choose_attack_zone();

        if(isDefined(self.script_noteworthy) && self.script_noteworthy == "guard_tower") {
          self allowedstances("stand");
          thread boss_fight_combat();
        }

        thread blueprint_maxpermatch();
      }

      function blueprintcreatingteam(var0) {
        self endon("death");
        self endon("game_ended");
        self cleargoalvolume();
        self setgoalpos(self.origin);
        thread bot_cache_entrances_to_zones(30);
        thread bonus_target_domage();
        scripts\engine\utility::ref_143aa("bullet_whizby", "damage", "weapon_fired", "grenade danger", "timeout", "proximty_alert");
        self notify("alert");
        self setgoalvolumeauto(var0);
      }

      function bot_cache_entrances_to_zones(var0) {
        self endon("death");
        self endon("game_ended");
        self endon("alert");
        wait var0;
        self notify("timeout");
      }

      function bonus_target_domage() {
        self endon("death");
        self endon("game_ended");
        self endon("alert");

        for(;;) {
          var0 = scripts\mp\utility\player::getplayersinradius(self.origin, 1000);

          if(var0.size > 0) {
            self notify("proximty_alert");
            var1 = scripts\engine\utility::random(var0);
            self agentsetfavoriteenemy(var1);
            self getenemyinfo(var1);
            break;
          }

          wait 1;
        }
      }

      function bomb_detonator_bomb_type() {
        if(!ispointonnavmesh(self.origin, self, 1)) {
          var0 = getclosestpointonnavmesh(self.origin, self);

          if(isDefined(var0)) {
            self forceteleport(var0, self.angles);
            return;
          }

          return;
        }
      }

      function boss_wave() {
        var0 = [];
        GscBinSkip0(0x2e, "AI_frag_grenade_mp", randomintrange(3000, 5000));
      }

      function bot_choose_attack_zone() {
        self endon("death");

        for(;;) {
          self waittill("grenade_fire", var0, var1, var2, var3);

          if(!scripts\mp\utility\weapon::grenadethrown(var0)) {
            continue;
          }

          scripts\mp\weapons::grenadeinitialize(var0, var1, var2, var3);
          self notify("grenade_throw");

          if(!isDefined(var0)) {
            return;
          }

          if(!isDefined(var0.weapon_name)) {
            return;
          }

          var0.spawnpos = var0.origin;

          switch (var0.weapon_name) {
            case "molotov_mp":
              thread scripts\mp\equipment\molotov::molotov_used(var0);
              break;
            case "gas_grenade_mp":
              thread scripts\mp\equipment\gas_grenade::gas_used(var0);
              break;
          }
        }
      }

      function boss_fight_combat() {
        self endon("death");
        self endon("game_ended");

        for(;;) {
          if(isDefined(self.enemy) && isPlayer(self.enemy) && (self.enemy isparachuting() || self.enemy isskydiving())) {
            _testing_ending::ref_13122(0.2);
          }

          _testing_ending::ref_13122(self.circleclosestarttime.baseaccuracy);
          wait 1;
        }
      }

      function blueprint_maxpermatch() {
        self endon("game_ended");
        self waittill("death", var0);
        level.are_all_hvts_eliminated = scripts\engine\utility::array_remove(level.are_all_hvts_eliminated, self);

        if(isDefined(var0) && isPlayer(var0)) {
          var1 = "kill";
          var0 thread scripts\mp\rank::giverankxp(var1, 100);
          var0 thread scripts\mp\rank::scoreeventpopup(var1);
        }

        var2 = spawnStruct();
        var2.origin = self.origin;
        var2.angles = self.angles;
        var2.dropstruct = scripts\mp\gametypes\br_pickups::test_ai_anim();
        var2.itemsdropped = 0;
        var2.heightoffset = 0;
        var2 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(0, 1, "ammo");
        var2.heightoffset += 3;
        var2 scripts\mp\gametypes\br_lootcache::chooseandspawnitems(1, 1, "plunder");
        var2.heightoffset += 3;
        var3 = bonusobjectivescorecharge();
        var4 = scripts\mp\gametypes\br_lootcache::ref_11a41(var3, var2.dropstruct, var2.origin, var2.angles, 0, 1, 0);
        var2.heightoffset += 3;
      }

      function bonusobjectivescorecharge() {
        if(!isDefined(level.arena_bot_out_of_ammo)) {
          bot_br_circle_think();
        }

        return scripts\engine\utility::random(level.arena_bot_out_of_ammo);
      }

      function bot_br_circle_think() {
        level.arena_bot_out_of_ammo = [];
        level.arena_bot_out_of_ammo["brloot_offhand_gas"] = "brloot_offhand_gas";
        level.arena_bot_out_of_ammo["brloot_offhand_smoke"] = "brloot_offhand_smoke";
        level.arena_bot_out_of_ammo["brloot_offhand_flash"] = "brloot_offhand_flash";
        level.arena_bot_out_of_ammo["brloot_killstreak_precision_airstrike"] = "brloot_killstreak_precision_airstrike";
        level.arena_bot_out_of_ammo["brloot_killstreak_uav"] = "brloot_killstreak_uav";
        level.arena_bot_out_of_ammo["brloot_equip_gasmask_durable"] = "brloot_equip_gasmask_durable";
        level.arena_bot_out_of_ammo["brloot_health_adrenaline"] = "brloot_health_adrenaline";
        level.arena_bot_out_of_ammo["brloot_super_nova_rounds"] = "brloot_super_nova_rounds";
        level.arena_bot_out_of_ammo["brloot_offhand_decon_station"] = "brloot_offhand_decon_station";
      }

      function next_drone_cd(var0, var1) {
        var2 = var1 * var1;

        foreach(var4 in level.are_all_hvts_eliminated) {
          if(!isDefined(var4)) {
            continue;
          }

          if(distance2dsquared(var4.origin, var0) > var2) {
            level.are_all_hvts_eliminated = scripts\engine\utility::array_remove(level.are_all_hvts_eliminated, var4);
            var4 dodamage(var4.health, var4.origin, var4, undefined, "MOD_TRIGGER_HURT");
          }
        }
      }