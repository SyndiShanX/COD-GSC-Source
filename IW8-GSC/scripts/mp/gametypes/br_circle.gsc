/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_circle.gsc
***********************************************/

function initcircle() {
  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee("circle")) {
    level.br_circle_disabled = 1;
    return;
  }

  if(!isDefined(level.br_level)) {
    return;
  }

  level.br_circle = spawnStruct();
  level.br_circle.mapbounds = level.br_level.br_mapbounds;

  if(getdvarint("scr_br_circle_fixed_damage", 0) > 0) {
    level.br_circle.damagetick = [getdvarint("scr_br_circle_fixed_damage", 0)];
  } else if(level.mapname == "mp_quarry2" || level.mapname == "mp_prison" || level.mapname == "mp_lumber") {
    level.br_circle.damagetick = [9, 9, 9, 9, 9];
  } else {
    level.br_circle.damagetick = [9, 9, 9, 9, 9, 9, 9, 9];
  }

  ref_1312a();
  var0 = getdvarvector("br_final_circle_override", (0, 0, 0));

  if(length(var0) > 0) {
    level.br_circle.br_finalcircleoverride = var0;
  }

  if(scripts\mp\gametypes\br_gametypes::tutorial_showtext("getFinalCircleCenter")) {
    level.br_circle.br_finalcircleoverride = scripts\mp\gametypes\br_gametypes::ref_12e05("getFinalCircleCenter");
  }

  setomnvar("ui_br_minimap_radius", level.br_level.br_circleminimapradii[0]);
  level.br_circle.circleindex = -1;
  allplayers_setphysicaldof();
  var1 = level.br_level.br_circleradii.size;

  if(isDefined(var1) && var1 > 0) {
    teleport_entities_inside_subway_car(var1);
    return;
  }

  teleport_entities_inside_subway_car(12);
}

function ref_1312a() {
  if(!isDefined(level.debug_vault_assault_retrieve_saw_obj_start)) {
    level.debug_vault_assault_retrieve_saw_obj_start = [];
  }

  if(getDvar("scr_br_circle_exclude_values") != "") {
    var0 = strtok(getDvar("scr_br_circle_exclude_values"), ",");

    if(var0.size % 4 != 0) {
      return;
    }

    for(var1 = 0; var1 < var0.size; var1++) {
      var2 = int(var0[var1]);
      var3 = var2 + "";

      if(var3 != var0[var1]) {
        return;
      }

      var0 = var2;
    }

    var1 = 0;

    while(var1 < var0.size) {
      level.debug_vault_assault_retrieve_saw_obj_start[level.debug_vault_assault_retrieve_saw_obj_start.size] = init_safehouse_gunshop((var0[var1], var0[var1 + 1], var0[var1 + 2]), var0[var1 + 3]);
      var1 += 4;
    }

    return;
  }
}

function teleport_players_inside_subway_car(var0, var1, var2, var3, var4) {
  if(isDefined(level.br_circle)) {
    return;
  }

  level.br_circle = spawnStruct();
  level.br_circle.mapbounds = level.br_level.br_mapbounds;
  level.br_circle.damagetick = [9, 9, 9, 9, 9, 9, 9, 9];
  var5 = level.br_level.br_circleclosetimes.size - 1;

  if(!isDefined(var2) || var2 < 0) {
    var2 = 0;
  } else if(var2 > var5) {
    var2 = var5;
  }

  var6 = level.br_level.br_circleclosetimes.size - var2;
  var7 = level.br_level.br_circleradii[0];

  if(!isDefined(var3) || var3 <= 0) {
    var3 = level.br_level.br_circleclosetimes[0];
  }

  level.br_circle.circleindex = -1;
  level.br_level.ground_trigger_pipes_room = undefined;
  level.br_circle.damagetick = ignorefallback(level.br_circle.damagetick, var2);
  level.br_level.br_circleclosetimes = ignorefallback(level.br_level.br_circleclosetimes, var2);
  level.br_level.br_circledelaytimes = safehouse_vo_return_end(var6, var1);
  level.br_level.default_player_connect_black_screen = safehouse_vo_return_end(var6, var1);
  level.br_level.default_suicidebomber_combat = ignorefallback(level.br_level.default_suicidebomber_combat, var2);
  level.br_level.br_circleminimapradii = ignorefallback(level.br_level.br_circleminimapradii, var2);
  level.br_level.br_circleradii = ignorefallback(level.br_level.br_circleradii, var2);
  level.br_level.br_circleradii[0] = var7;
  level.br_level.br_circleclosetimes[0] = var3;

  if(isDefined(var4)) {
    level.br_level.br_circledelaytimes[1] = var4;
  }

  level.br_circle.br_finalcircleoverride = var0;
  cacheentity();
  thread allplayers_setphysicaldof();
  level.br_circle.br_finalcircleoverride = undefined;
  level notify("CirclePeekCleanup");

  if(isDefined(level.gulag_tutorial_vo)) {
    foreach(var9 in level.gulag_tutorial_vo) {
      var9 delete();
    }

    level.gulag_tutorial_vo = undefined;
    scripts\mp\gametypes\br_quest_util::ref_13234();
  }

  thread ref_12e09(0);
}

function ignorefallback(var0, var1) {
  if(var1 == 0) {
    return var0;
  }

  var0 = scripts\engine\utility::array_slice(var0, var1, var0.size);
  return var0;
}

function safehouse_vo_return_end(var0, var1) {
  var2 = [];
  GscBinSkip0(0x2e, 0, var1);
}

function getsafecircleorigin() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    return (level.br_circle.safecircleent.origin[0], level.br_circle.safecircleent.origin[1], 0);
  }

  return (0, 0, 0);
}

function getsafecircleradius() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.safecircleent)) {
    return level.br_circle.safecircleent.origin[2];
  }

  return 0;
}

function getdangercircleorigin() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
    return (level.br_circle.dangercircleent.origin[0], level.br_circle.dangercircleent.origin[1], 0);
  }

  return (0, 0, 0);
}

function getdangercircleradius() {
  if(isDefined(level.br_circle) && isDefined(level.br_circle.dangercircleent)) {
    return level.br_circle.dangercircleent.origin[2];
  }

  return 0;
}

function reset_timescalefactor() {
  var0 = level.br_circle.circleindex + 2;

  if(var0 < level.br_level.default_class_chosen.size) {
    return level.br_level.default_class_chosen[var0];
  }

  return undefined;
}

function reset_totals_keep_type() {
  var0 = level.br_circle.circleindex + 2;

  if(var0 < level.br_level.br_circleradii.size) {
    return level.br_level.br_circleradii[var0];
  }

  return undefined;
}

function get_best_goal_closest_to_any_player() {
  return isDefined(level.br_circle.safecircleent) && !istrue(level.br_circle.safecircleent.hidden);
}

function get_bcrumbstruct_proximity() {
  return isDefined(level.br_circle.dangercircleent) && !istrue(level.br_circle.dangercircleent.hidden);
}

function ref_12519() {
  if(istrue(self.ref_14439)) {
    return false;
  }

  if(istrue(self.gulag)) {
    if(istrue(self.gulagarena) || istrue(self.jailed)) {
      return false;
    }
  }

  if(istrue(self.unset_relic_thirdperson)) {
    return false;
  }

  return get_bcrumbstruct_proximity();
}

function cancircledamageplayer(var0) {
  return isalive(var0) && ref_12519(var0) && !istrue(var0.gulag) && !istrue(var0.inrespawnc130) && !var0 scripts\mp\gametypes\br_public::ref_125f3() && !var0 scripts\mp\gametypes\br_public::ref_125ec();
}

function ref_13e18() {
  var0 = self;

  if(!var0 scripts\cp_mp\utility\player_utility::_isalive() || istrue(level.vehicle_collision_getleveldata)) {
    return;
  }

  if(!isDefined(var0.operatorcustomization)) {
    return;
  }

  if(var0 scripts\mp\utility\killstreak::isjuggernaut()) {
    return;
  }

  if(isDefined(var0.did_ads_hint) && gettime() < var0.did_ads_hint) {
    return;
  }

  var0.did_ads_hint = gettime() + randomintrange(5000, 7000);

  if(!isai(var0)) {
    var0 playsoundtoplayer("gas_player_cough", var0, var0);
  }

  var1 = "allies_male_cough";
  var2 = scripts\mp\gametypes\br_public::disableannouncer(var0);
  var3 = var0.operatorcustomization.gender;

  if(var2 == "axis") {
    if(isDefined(var3) && var3 == "female") {
      var1 = "axis_female_cough";
    } else {
      var1 = "axis_male_cough";
    }
  } else if(isDefined(var3) && var3 == "female") {
    var1 = "allies_female_cough";
  } else {
    var1 = "allies_male_cough";
  }

  var4 = randomint(game["dialogue"][var1].size);
  var5 = game["dialogue"][var1][var4];
  var0 playsoundonmovingent(var5);
}

function ref_131a0() {
  if(!isDefined(self.ref_125e4)) {
    self.ref_125e4 = gettime();
    return;
  }
}

function ref_12c79() {
  self.ref_125e4 = undefined;
}

function firstteam() {
  var0 = [60, 90, 120];
  var1 = [2, 3, 10];
  var2 = spawnStruct();
  var2.enabled = getdvarint("scr_player_gas_timer_mult_enabled", 1);
  var2.ref_11f3f = getdvarint("scr_player_gas_timer_mult_count", 3);
  var2.ref_13b7b = [];
  var2.ref_11e09 = [];
  var3 = 0;
  var4 = 1;

  for(var5 = 0; var5 < var2.ref_11f3f; var5++) {
    var6 = undefined;
    var7 = undefined;

    if(var5 < var0.size) {
      var6 = var0[var5];
      var7 = var1[var5];
      var3 = var6;
      var4 = var7;
    } else {
      var3 += 1;
      var4 += 1;
      var6 = var3;
      var7 = var4;
    }

    var2.ref_13b7b[var5] = getdvarfloat("scr_player_gas_timer_mult_time_" + scripts\engine\utility::string(var5 + 1), var6);
    var2.ref_11e09[var5] = getdvarfloat("scr_player_gas_timer_mult_mult_" + scripts\engine\utility::string(var5 + 1), var7);
  }

  return var2;
}

function relic_nuketimer(var0, var1) {
  if(!var0.enabled) {
    return var1;
  }

  if(!isDefined(self.ref_125e4)) {
    return var1;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle()) {
    if(isDefined(level.ffsm_onground_stateenter) && self.vehicle.vehiclename == "veh_bt") {
      return level.ffsm_onground_stateenter;
    }

    if(isDefined(level.pickedupcoreminigun) && self.vehicle.vehiclename == "veh_a10fd") {
      return level.pickedupcoreminigun;
    }
  }

  var2 = (gettime() - self.ref_125e4) * 0.001;
  var3 = var0.ref_11f3f - 1;

  while(var3 >= 0) {
    var4 = var0.ref_13b7b[var3];

    if(var2 >= var4) {
      var5 = var0.ref_11e09[var3];
      return int(var1 * var5);
    }

    var4--;
  }

  return var2;
}

function circledamagetick() {
  level endon("game_ended");
  level endon("endCircleDamageTick");

  while(level.br_circle.circleindex < 0) {
    waitframe();
  }

  if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("circleEarlyStart")) {
    level waittill("infils_ready");
  }

  var0 = getdvarfloat("scr_br_circle_object_cleanup_threshold", 2400);
  var1 = getdvarfloat("scr_br_circle_radio_cleanup_threshold", 1000);
  var2 = firstteam();

  for(;;) {
    if(isDefined(level.br_circle.dangercircleent)) {
      var3 = level.br_circle.circleindex;

      if(var3 > level.br_circle.damagetick.size - 1) {
        var3 = level.br_circle.damagetick.size - 1;
      }

      var4 = level.br_circle.damagetick[var3];

      if(isDefined(level.circledamagemultiplier)) {
        var4 *= level.circledamagemultiplier;
      }

      if(var4 > 0) {
        var5 = getdangercircleorigin();
        var6 = getdangercircleradius();

        foreach(var8 in level.players) {
            if(!isDefined(var8) || !isDefined(var8.origin)) {
              continue;
            }

            if(isDefined(var8) && istrue(var8.start_death_from_above_sequence)) {
              continue;
            }

            if(scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params("circleEarlyStart") && istrue(var8.plotarmor)) {
              ref_12c79(var8);
              continue;
            }

            var9 = 0;

            if(distance2dsquared(var5, var8.origin) > var6 * var6) {
              if(cancircledamageplayer(var8, var8)) {
                var9 = 1;
                ref_131a0(var8);
                var10 = relic_nuketimer(var8, var2, var4);

                if(scripts\cp_mp\gasmask::hasgasmask(var8)) {
                  if(scripts\mp\gametypes\br_pickups::ks_circlecount(var8)) {
                    if(!istrue(var8.gasmaskequipped)) {
                      ref_1384c(var8, var10);

                      if(!isalive(var8)) {
                        continue;
                      }
                    }

                    var8 scripts\cp_mp\gasmask::processdamage(var10);
                  } else {
                    if(!istrue(level.±‚À‹ X3Û < å`²aÄ7xë<‘ ) && !istrue( var8.gasmaskequipped ) && !istrue( var8.gasmaskswapinprogress ) && var8 method_87eb() )
{
ref_1384c( var8, var10 );

if( !isalive( var8 ) )
{
continue;
}
}

if( isDefined( var8.gasmaskhealth ) && var8.gasmaskhealth <= 0 )
{
var8 playsoundtoplayer( "br_gas_mask_crack_plr", var8 );
var8 scripts\mp\gametypes\br_pickups::handleweaponreloadammodrop();
}
else
{
var8 scripts\mp\gametypes\br_pickups::plunderrepositoryref( "br_circle" );
var8 scripts\cp_mp\gasmask::processdamage( var10 );
}
}
}
else
{
ref_1384c( var8, var10 );
}
}
else
{
ref_12c79( var8 );
}
}
else
{
ref_12c79( var8 );

if( scripts\cp_mp\gasmask::hasgasmask( var8 ) )
{
if( scripts\mp\gametypes\br_pickups::ks_circlecount( var8 ) )
{
continue;
}
else if( isDefined( var8.gasmaskhealth ) && var8.gasmaskhealth <= 0 )
{
var8 playsoundtoplayer( "br_gas_mask_crack_plr", var8 );
var8 scripts\mp\gametypes\br_pickups::handleweaponreloadammodrop();
}
else
{
var8 scripts\mp\gametypes\br_pickups::plunderrankupdate( "br_circle" );
}
}
}

if( scripts\mp\utility\game::getgametype() == "br" )
{
ref_13fe3( var8, var9 );
}
}

var12 = var6 + var0;
var13 = var6 + var1;
scripts\mp\gametypes\br_plunder::dangercircletick( var5, var12 );
scripts\mp\gametypes\br_respawn::dangercircletick( var5, var12 );
scripts\mp\gametypes\br_quest_util::dangercircletick( var5, var6, var12 );
scripts\mp\gametypes\br_armory_kiosk::dangercircletick( var5, var12 );
scripts\mp\gametypes\br_armory_trader::dangercircletick( var5, var12 );
scripts\mp\gametypes\br_vehicles::dangercircletick( var5, var6 );
scripts\mp\gametypes\br_pickups::dangercircletick( var5, var6 );
scripts\mp\gametypes\br_publicevents::dangercircletick( var5, var6 );
scripts\mp\gametypes\br_satellite_hunt::dangercircletick( var5, var6 );
scripts\mp\gametypes\br_numbers_tower::dangercircletick( var5, var6 );
scripts\mp\equipment\binoculars::isbossheli( var5, var6 );
scripts\mp\gametypes\br_gametypes::ref_12e05( "dangerCircleTick", var5, var12 );
scripts\mp\gametypes\br_gametypes::ref_12e05( "dangerCircleTickActual", var5, var6 );
_findgivearmoramountanddropleftovers::dangercircletick( var5, var12 );

if( getdvarint( "scr_br_alt_mode_escape", 0 ) )
{
scripts\mp\gametypes\br_alt_mode_escape::dangercircletick( var5, var13, var6 );
}

if( getdvarint( "scr_city_killers_convoy_event_active", 0 ) && isDefined( level.hudextractnum ) )
{
[[ level.hudextractnum ]]( var5, var6 );
}

if( getdvarint( "scr_br_using_exfil_radio", 0 ) && isDefined( level.onmatchplacement ) )
{
[[ level.onmatchplacement ]]( var5, var13, var6 );
}

if( getdvarint( "scr_wz320_ai_events", 0 ) && isDefined( level.next_drone_cd ) )
{
[[ level.next_drone_cd ]]( var5, var6 );
}
}
}

wait 1;
}
}

function ref_1384c( var0 )
{
var1 = self;

if( isDefined( level.ref_11c95 ) )
{
var0 = var1 [[ level.ref_11c95 ]]( var0 );
}

if( var1 scripts\mp\utility\killstreak::isjuggernaut() )
{
var0 = scripts\mp\gametypes\br_jugg_common::ref_11c95( var0 );
}

var1 dodamage( var0, var1.origin, var1, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );

if( var1 scripts\mp\gametypes\br_public::hasarmor() )
{
var1 scripts\mp\gametypes\br_public::damagearmor( var0 );
}

if( isalive( var1 ) )
{
ref_13e18( var1 );
return;
}
}

function ref_13fe3( var0 )
{
if( !isDefined( self.unset_relic_shieldsonly ) )
{
self.unset_relic_shieldsonly = var0;
self.waittill_see_infl_lbravo_long_enough = gettime();
}

if( self.unset_relic_shieldsonly != var0 )
{
self.unset_relic_shieldsonly = var0;
var1 = gettime();

if( var0 )
{
scripts\cp\vehicles\vehicle_compass_cp::ref_1383b( "alive_in_gas" );
scripts\mp\gametypes\br_analytics::descendpos( self, var1 - self.waittill_see_infl_lbravo_long_enough );
}
else
{
scripts\cp\vehicles\vehicle_compass_cp::ref_138d5( "alive_in_gas" );
scripts\mp\gametypes\br_analytics::descendsolostarts( self, var1 - self.waittill_see_infl_lbravo_long_enough );
}

self.waittill_see_infl_lbravo_long_enough = var1;
return;
}
}

function startuiclosetimer( var0, var1, var2, var3 )
{
level endon( "game_ended" );

if( istrue( scripts\mp\gametypes\br_gametypes::ref_12e07( "startUICloseTimer", var0, var1, var2, var3 ) ) )
{
return;
}

setomnvar( "ui_hardpoint_timer", gettime() + int( var0 * 1000 ) );
var4 = ref_13322();

if( var1 == 0 )
{
var1 = !scripts\mp\flags::gameflag( "br_ready_to_jump" );
}

if( !var1 )
{
foreach ( var6 in level.players )
{
if( !isbot( var6 ) && !var6 scripts\mp\gametypes\br_public::isplayeringulag() )
{
if( istrue( var2 ) )
{
var6 thread scripts\mp\hud_message::showsplash( "br_final_circle" );
continue;
}

if( !var4 || var3 > 1 )
{
var6 thread scripts\mp\hud_message::showsplash( "br_new_circle" );
}
}
}
}

if( istrue( var2 ) )
{
setomnvar( "ui_br_circle_state", 3 );
}
else
{
setomnvar( "ui_br_circle_state", 0 );
}

var8 = [ 60, 30, 20, 10, 0 ];
var9 = var8.size - 1;

for( var10 = 0; var10 < var8.size ; var10++ )
{
if( var0 > var8[ var10 ] )
{
var9 = var10;
break;
}
}

if( var0 < var8[ var9 ] )
{
return;
}

wait var0 - var8[ var9 ];

for( var10 = var9; var10 < var8.size - 1 ; var10++ )
{
if( var10 == 2 )
{
thread scripts\mp\music_and_dialog::debugtype();
}

if( var10 == 3 )
{
setomnvar( "ui_br_circle_state", 2 );
}

wait var8[ var10 ] - var8[ var10 + 1 ];
}

level notify( "br_circle_closing" );

if( !var1 )
{
foreach ( var6 in level.players )
{
if( !isbot( var6 ) && !var6 scripts\mp\gametypes\br_public::isplayeringulag() && ( !var4 || var3 > 0 ) )
{
if( istrue( level.vehicle_collision_getleveldata ) )
{
var6 scripts\engine\utility::delaythread( 2, &scripts\mp\hud_message::showsplash, "br_x1_1" );
}
else
{
var6 thread scripts\mp\hud_message::showsplash( "br_circle_moving" );
}

var6 playlocalsound( "br_circle_closing" );
}
}
}

setomnvar( "ui_br_circle_state", 1 );
}

function all_players_are_in_trap_room_entrance()
{
setomnvar( "ui_br_circle0_start_time", 0 );
}

function ref_131ad( var0 )
{
if( scripts\mp\utility\game::round_vehicle_logic() != "reveal" && scripts\mp\utility\game::round_vehicle_logic() != "x2" && scripts\mp\utility\game::round_vehicle_logic() != "respect" )
{
setomnvar( "ui_br_circle0_start_entity", var0 );
}

setomnvar( "ui_br_circle0_end_entity", var0 );
}

function setstaticuicircles( var0, var1, var2, var3 )
{
var4 = ammo_buy_point_loop( var0 );
setomnvar( "ui_br_circle0_start_time", gettime() );
setomnvar( "ui_br_circle0_duration", var4 );

if( scripts\mp\utility\game::round_vehicle_logic() != "reveal" && scripts\mp\utility\game::round_vehicle_logic() != "x2" && scripts\mp\utility\game::round_vehicle_logic() != "respect" )
{
setomnvar( "ui_br_circle0_start_entity", var1 );
}

setomnvar( "ui_br_circle0_end_entity", var1 );

if( istrue( var3 ) )
{
all_players_are_in_trap_room_entrance();
}

var4 = adjust_damage_based_on_weaponclass( var0 );
setomnvar( "ui_br_circle1_start_time", gettime() );
setomnvar( "ui_br_circle1_duration", var4 );
setomnvar( "ui_br_circle1_start_entity", var2 );
setomnvar( "ui_br_circle1_end_entity", var2 );
thread updatecirclehide( var0, var1, var2 );
}

function setclosinguicircle( var0, var1, var2, var3 )
{
var4 = ammo_buy_point_loop( var0 );
setomnvar( "ui_br_circle0_start_time", gettime() );
setomnvar( "ui_br_circle0_duration", var4 );

if( scripts\mp\utility\game::round_vehicle_logic() != "reveal" && scripts\mp\utility\game::round_vehicle_logic() != "x2" && scripts\mp\utility\game::round_vehicle_logic() != "respect" )
{
setomnvar( "ui_br_circle0_start_entity", var1 );
}

setomnvar( "ui_br_circle0_end_entity", var1 );

if( istrue( var3 ) )
{
all_players_are_in_trap_room_entrance();
}

var4 = adjust_damage_based_on_weaponclass( var0 );
setomnvar( "ui_br_circle1_start_time", gettime() );
setomnvar( "ui_br_circle1_duration", var4 );
setomnvar( "ui_br_circle1_start_entity", var2 );
setomnvar( "ui_br_circle1_end_entity", var1 );
thread updatecirclehide( var0, var1, var2 );
}

function updatecirclehide( var0, var1, var2 )
{
level notify( "update_circle_omnvars" );
level endon( "update_circle_omnvars" );

for( ;; )
{
level waittill( "update_circle_hide" );
var3 = ammo_buy_point_loop( var0 );
setomnvar( "ui_br_circle0_duration", var3 );
var3 = adjust_damage_based_on_weaponclass( var0 );
setomnvar( "ui_br_circle1_duration", var3 );
}
}

function adjust_damage_based_on_weaponclass( var0 )
{
if( get_bcrumbstruct_proximity() )
{
return int( var0 * 1000 );
}

return 0;
}

function ammo_buy_point_loop( var0 )
{
if( get_best_goal_closest_to_any_player() )
{
return int( var0 * 1000 );
}

return 0;
}

function islastcircle()
{
return level.br_circle.circleindex >= level.br_level.br_circleradii.size - 1 || !( level.br_level.br_circleradii[ level.br_circle.circleindex + 1 ] > 0 );
}

function groupindex( var0 )
{
var1 = level.br_level.br_circledelaytimes[ var0 ];
var2 = level.br_level.br_circleclosetimes[ var0 ];
var3 = var1 + var2;
return var3;
}

function inithelirepository()
{
var0 = level.br_circle.circleindex;
var1 = groupindex( var0 );
var2 = level.br_circle.starttime / 1000;
var3 = gettime() / 1000 - var2;
return var1 - var3;
}

function iscurrentcircleclosing()
{
var0 = level.br_circle.circleindex;

if( !isDefined( var0 ) || var0 < 0 )
{
return false;
}

var1 = inithelirepository();
var2 = level.br_level.br_circleclosetimes[ var0 ];
return var1 <= var2;
}

function helibankplunder( var0, var1, var2 )
{
var3 = scripts\engine\utility::array_randomize( scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon( var0.team, var0.squadindex ) );
var4 = undefined;

foreach ( var6 in var3 )
{
if( var6 != var0 )
{
var4 = var6;
break;
}
}

if( !isDefined( var4 ) )
{
return undefined;
}

if( !isDefined( var1 ) )
{
var1 = 0;
}

var8 = var4.origin;
var9 = level.br_circle.circleindex;
var10 = level.br_circle.starttime / 1000;
var11 = var1 + gettime() / 1000 + var2;
var12 = max( var11 - var10 - level.br_level.br_circledelaytimes[ var9 ], 0 );
var13 = int( min( var9 + 1, level.br_level.default_class_chosen.size - level.br_level.delay_start_escort_protect_hvi_objective - 1 ) );
var14 = level.br_level.br_circleclosetimes[ var9 ];
var15 = level.br_level.default_class_chosen[ var9 ];
var16 = level.br_level.br_circleradii[ var9 ];
var17 = level.br_level.default_class_chosen[ var13 ];
var18 = level.br_level.br_circleradii[ var13 ];
var19 = ( var17 - var15 ) / var14;
var20 = ( var18 - var16 ) / var14;
var21 = var15 + var19 * var12;
var22 = var16 + var20 * var12;
var23 = distance2d( var8, var21 );

if( var23 == 0 )
{
return undefined;
}

var24 = getdvarfloat( "scr_br_respawn_dist_away", 1000 );
var25 = var8 + ( var21 - var8 ) * var24 / var23;

if( vandalize_minigun_speed( var25, 0, var1 + var2 ) )
{
return var25;
}

var26 = getdvarfloat( "scr_br_respawn_dist_fraction_away", 0.5 );
var24 = var23 * var26;
var25 = var8 + ( var21 - var8 ) * var24 / var23;

if( vandalize_minigun_speed( var25, 0, var1 + var2 ) )
{
return var25;
}

var27 = var8 - var21;
var25 = var21 + var22 / var23 * var27;

if( vandalize_minigun_speed( var25, 0, var1 + var2 ) )
{
return var25;
}

return undefined;
}

function vandalize_minigun_speed( var0, var1, var2 )
{
if( !scripts\mp\gametypes\br_c130::ispointinbounds( var0, 1 ) )
{
return false;
}

if( istrue( var1 ) && allassassin_teamcompare( var0 ) )
{
return false;
}

if( isDefined( var2 ) )
{
var3 = getmintimetillpointindangercircle( var0 );

if( var2 > var3 )
{
return false;
}
}

return true;
}

function closestsafeperimeterpointfromsquadmate( var0, var1 )
{
if( isDefined( level.br_circle ) && isDefined( level.br_circle.safecircleent ) )
{
var2 = scripts\engine\utility::array_sort_with_func( scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon( self.team, self.squadindex ), &_compare_higher_health );

foreach ( var4 in var2 )
{
if( var4 != self )
{
if( var4 scripts\mp\gametypes\br_public::updateinstantclassswapallowedinternal() == 0 )
{
var5 = _getclosestsafeperimeterpoint( var4.origin, var0, var1 );

if( isDefined( var5 ) )
{
return var5;
}
}
}
}
}

return undefined;
}

function _compare_higher_health( var0, var1 )
{
return var0.health >= var1.health;
}

function closestsafeperimeterpointfromloadout( var0, var1 )
{
if( isDefined( level.br_circle ) && isDefined( level.br_circle.safecircleent ) )
{
foreach ( var3 in level.br_pickups.crates )
{
if( !isDefined( var3 ) || !isDefined( var3.team ) || var3.team != self.team )
{
continue;
}

if( isDefined( var3.playerscaptured ) && isDefined( var3.playerscaptured[ self getentitynumber() ] ) )
{
continue;
}

var4 = _getclosestsafeperimeterpoint( var3.origin, var0, var1 );

if( isDefined( var4 ) )
{
return var4;
}
}
}

return undefined;
}

function _getclosestsafeperimeterpoint( var0, var1, var2 )
{
var3 = getsafecircleorigin();
var4 = float( getsafecircleradius() );
var5 = getdangercircleorigin();
var6 = getdangercircleradius();
var7 = var4 * var4;

if( var7 > 0 )
{
var8 = distance2d( var0, var5 );

if( var8 == 0 )
{
return var0;
}

var6 = min( var6, var8 );
var9 = 4;

for( var10 = var9; var10 >= 0 ; var10-- )
{
var11 = var6 * var10 / var9;
var12 = ( var0 - var5 ) * var11 / var8 * var1 + var5;

if( vandalize_minigun_speed( var12, 0, var2 ) )
{
if( getdvarint( "scr_br_maxRespawnSnapToNavMesh", 1 ) == 1 && isscriptabledefined() )
{
var12 = getclosestpointonnavmesh( var12 );

if( vandalize_minigun_speed( var12, 0, var2 ) == 0 )
{
continue;
}
}

return var12;
}
}
}

return undefined;
}

function risk_flagspawnshiftingpercent( var0, var1, var2, var3, var4, var5, var6, var7 )
{
var5 = istrue( var5 ) && isscriptabledefined();
var8 = 8;
var9 = var0;
var10 = 0;
var11 = 0;
var12 = 360;

while( var10 < var8 )
{
var13 = getrandompointincircle( var0, var1, var2, var3, 1, 0, var11, var12 );

if( vandalize_minigun_speed( var13, var6, var7 ) )
{
var9 = var13;

if( var5 )
{
var13 = getclosestpointonnavmesh( var9 );

if( vandalize_minigun_speed( var13, var6, var7 ) )
{
var9 = var13;
break;
}
}
else
{
break;
}
}

var14 = level.br_level.default_class_chosen[ 0 ] - var0;
var14 = ( var14[ 0 ], var14[ 1 ], 0 );
var15 = vectortoangles( var14 )[ 1 ];
var16 = ( 1 - var10 / var8 ) * 180;
var11 = var15 - var16;
var12 = var15 + var16;
var10++;
}

return var9;
}

function getrandompointincircle( var0, var1, var2, var3, var4, var5, var6, var7 )
{
if( var1 <= 0 )
{
return var0;
}

var8 = 0;

if( isDefined( var2 ) )
{
var8 = var2;
}

var9 = 1;

if( isDefined( var3 ) )
{
var9 = var3;
}

if( !isDefined( var4 ) )
{
var4 = 1;
}

if( !isDefined( var5 ) )
{
var5 = 1;
}

if( !isDefined( var6 ) )
{
var6 = 0;
}

if( !isDefined( var7 ) )
{
var7 = 360;
}

var10 = squared( var1 * var8 );
var11 = squared( var1 * var9 );
var12 = undefined;

if( var10 == var11 )
{
var12 = sqrt( var10 );
}
else
{
var12 = sqrt( randomfloatrange( var10, var11 ) );
}

var13 = var6 + randomfloat( var7 - var6 );
var14 = ( var12 * cos( var13 ), var12 * sin( var13 ), 0 );
var15 = var0 + var14;

if( var4 )
{
var16 = scripts\mp\gametypes\br_public::semtex_used();
var17 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
var15 = scripts\mp\gametypes\br_public::modifyplayer_damage( ( var0[ 0 ], var0[ 1 ], 0 ) + var14, var16 );
}

if( var5 && isscriptabledefined() )
{
var15 = getclosestpointonnavmesh( var15 );
}

return var15;
}

function getrandompointincurrentcircle( var0, var1 )
{
var2 = getdangercircleorigin();
var3 = level.br_level.br_circleradii[ level.br_circle.circleindex + 1 ];
return getrandompointincircle( var2, var3, var0, var1 );
}

function riskspawn_flagspawnbytier( var0, var1 )
{
var2 = getsafecircleorigin();
var3 = getsafecircleradius();
return getrandompointincircle( var2, var3, var0, var1 );
}

function risk_modifyflagstieronrespawn( var0, var1 )
{
var2 = getsafecircleorigin();
var3 = getsafecircleradius();
return risk_flagspawnshiftingpercent( var2, var3, var0, var1 );
}

function ispointincurrentsafecircle( var0 )
{
if( !isDefined( level.br_circle.dangercircleent ) )
{
return false;
}

var1 = ( level.br_circle.dangercircleent.origin[ 0 ], level.br_circle.dangercircleent.origin[ 1 ], 0 );
var2 = float( level.br_level.br_circleradii[ level.br_circle.circleindex + 1 ] );
var3 = distance2dsquared( var0, var1 );

if( var3 < var2 * var2 )
{
return true;
}

return false;
}

function updateprestreamrespawn( var0 )
{
if( !isDefined( level.br_circle.dangercircleent ) )
{
return false;
}

var1 = getdangercircleorigin();
var2 = float( getdangercircleradius() );
var3 = distance2dsquared( var1, var0 );
var4 = var2 * var2;
return var3 < var4;
}

function updatescavengerhud( var0 )
{
var1 = reset_timescalefactor();
var2 = float( reset_totals_keep_type() );

if( !isDefined( var1 ) || !isDefined( var2 ) )
{
return false;
}

var3 = distance2dsquared( var0, var1 );

if( var3 < var2 * var2 )
{
return true;
}

return false;
}

function isblocked()
{
self endon( "death" );

for( ;; )
{
self show();

foreach ( var1 in level.players )
{
if( !ref_12519( var1 ) )
{
self hidefromplayer( var1 );
}
}

level waittill( "update_circle_hide" );
}
}

function allassassin_teamcompare( var0 )
{
if( getdvarint( "scr_br_badAreaKillswitch", 0 ) == 1 )
{
return false;
}

if( !isDefined( level.debug_vault_assault_retrieve_saw_obj_start ) || level.debug_vault_assault_retrieve_saw_obj_start.size == 0 )
{
return false;
}

foreach ( var2 in level.debug_vault_assault_retrieve_saw_obj_start )
{
var3 = distance2dsquared( var0, var2.origin );

if( var3 < var2.ref_129e5 )
{
return true;
}
}

return false;
}

function allplayers_setphysicaldof( var0, var1 )
{
level.br_level.default_class_chosen = [];
var2 = ( level.br_circle.mapbounds[ 0 ] + level.br_circle.mapbounds[ 1 ] ) * 0.5;

if( scripts\mp\gametypes\br_gametypes::tutorial_showtext( "mapCenterFinalCircle" ) )
{
var2 = scripts\mp\gametypes\br_gametypes::ref_12e05( "mapCenterFinalCircle" );
}

level.br_level.default_class_chosen[ 0 ] = ( var2[ 0 ], var2[ 1 ], 0 );
var3 = var2[ 0 ];
var4 = var2[ 1 ];

if( istrue( level.br_level.ref_13884 ) )
{
level.br_level.default_class_chosen[ 0 ] = scripts\engine\utility::drop_to_ground( ( var3, var4, 4000 ) );
level.br_level.default_class_chosen[ 1 ] = level.br_level.default_class_chosen[ 0 ];
return;
}

var5 = getdvarfloat( "scr_br_circle_first_placement_scale", 0 );
var6 = var5 * level.br_level.br_circleradii[ 1 ];
var7 = [];
GscBinSkip0( 0x2e, 0, level.br_circle.mapbounds[ 0 ][ 0 ] - var6 );
}

function relic_amped_play_beep()
{
var0 = ( 0, 0, 0 );
var1 = [];
var2 = 1;
var3 = 0;

for( ;; )
{
var4 = getdvarvector( "scr_br_circle_end_pos_" + var2, var0 );

if( var4 == var0 )
{
break;
}

var5 = spawnStruct();
var5.pos = var4;
var5.radius = getdvarfloat( "scr_br_circle_end_pos_radius_" + var2, 0 );
var6 = getdvarfloat( "scr_br_circle_end_pos_weight_" + var2, 1 );

if( var6 > 0 )
{
var3 += var6;
var5.weight = var3;
var1 = var5;
}

var2++;
}

if( !var1.size )
{
return undefined;
}

var7 = undefined;
var8 = getdvarint( "scr_br_circle_end_pos_force_index", 0 );

if( var8 )
{
var8 -= 1;

if( var8 < var1.size )
{
var7 = var1[ var8 ];
}
}
else
{
var9 = randomfloatrange( 0, var3 );

for( var10 = 0; var10 < var1.size ; var10++ )
{
if( var9 < var1[ var10 ].weight )
{
var7 = var1[ var10 ];
break;
}
}
}

if( !isDefined( var7 ) )
{
return undefined;
}

if( var7.radius > 0 )
{
return risk_flagspawnshiftingpercent( var7.pos, var7.radius, 0, 1, 1, 1, 1 );
}

return var7.pos;
}

function ref_12e09( var0 )
{
level endon( "game_ended" );
level endon( "br_ending_start" );
level.br_circle.safecircleent = spawn( "script_model", ( level.br_level.default_class_chosen[ 1 ][ 0 ], level.br_level.default_class_chosen[ 1 ][ 1 ], level.br_level.br_circleradii[ 1 ] ) );
level.br_circle.safecircleent.hidden = 0;
level.br_circle.safecircleui = spawn( "script_model", level.br_circle.safecircleent.origin );
level.br_circle.safecircleui.hidden = 0;
level.br_circle.dangercircleent = spawnbrcircle( level.br_level.default_class_chosen[ 0 ][ 0 ], level.br_level.default_class_chosen[ 0 ][ 1 ], level.br_level.br_circleradii[ 0 ] );
level.br_circle.dangercircleent.hidden = 0;
thread isblocked();
level.br_circle.dangercircleui = spawn( "script_model", level.br_circle.dangercircleent.origin );
level.br_circle.dangercircleui.hidden = 0;
ref_131ad( level.br_circle.safecircleent );
spawn_carriable_at_struct();

if( istrue( var0 ) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee_params( "circleEarlyStart" ) )
{
level waittill( "infils_ready" );
}

if( istrue( level.usegulag ) )
{
scripts\mp\gametypes\br_gulag::ref_13249();
}

ref_13348();
thread circledamagetick();
thread ref_138d7();

if( isDefined( level.br_level.br_circledelaytimes ) )
{
for( var1 = 0; var1 < level.br_level.br_circledelaytimes.size ; var1++ )
{
circletimer( var1 );
}
}

scripts\mp\gametypes\br_armory_kiosk::little_bird_mg_initomnvars();
scripts\mp\gametypes\br_armory_trader::little_bird_mg_initspawning();
}

function ref_138d7()
{
level notify( "stopCirclesAtGameEnd" );
level endon( "stopCirclesAtGameEnd" );
level scripts\engine\utility::waittill_any_two( "game_ended", "br_ending_start" );

if( scripts\mp\utility\game::getgametype() == "br" )
{
setomnvar( "ui_hardpoint_timer", 0 );
return;
}
}

function relic_amped_reset_deathshield_on_revived( var0 )
{
if( !isDefined( level.br_circle ) )
{
return -1;
}

var1 = -1;

for( var2 = 0; var2 < level.br_level.default_class_chosen.size - level.br_level.delay_start_escort_protect_hvi_objective ; var2++ )
{
var3 = level.br_level.default_class_chosen[ var2 ];
var4 = level.br_level.br_circleradii[ var2 ];
var5 = distance2d( var0, var3 );

if( var5 >= var4 )
{
break;
}

var1 = var2;
}

return var1;
}

function getmintimetillpointindangercircle( var0 )
{
if( istrue( level.br_circle_disabled ) )
{
return 99999;
}

if( !isDefined( level.br_circle ) )
{
return -1;
}

if( istrue( level.br_level.ref_13884 ) )
{
return -1;
}

var1 = 0;

if( level.br_circle.circleindex >= 0 )
{
var2 = level.br_circle.circleindex;
var3 = level.br_circle.starttime;
var4 = level.br_circle.dangercircleent.origin[ 2 ];
var5 = level.br_circle.dangercircleent.origin;

if( var2 >= level.br_level.default_class_chosen.size - level.br_level.delay_start_escort_protect_hvi_objective )
{
var2 = level.br_level.default_class_chosen.size - 1;
}
}
else
{
var2 = 0;
var3 = gettime();
var4 = level.br_level.br_circleradii[ 0 ];
var5 = level.br_level.default_class_chosen[ 0 ];
}

var6 = relic_amped_reset_deathshield_on_revived( var4 );

if( var6 < 0 )
{
return var5;
}
else if( var6 < var2 )
{
return var5;
}
else if( var6 == var2 )
{
if( distance2d( var5, var4 ) > var4 )
{
return var5;
}
}

for( var7 = var2 + 1; var7 < var6 ; var7++ )
{
var5 += level.br_level.br_circleclosetimes[ var7 ];
var5 += level.br_level.br_circledelaytimes[ var7 ];
}

var8 = level.br_level.br_circledelaytimes[ var2 ];
var9 = level.br_level.br_circleclosetimes[ var2 ];
var10 = ( gettime() - var3 ) / 1000;

if( var6 > var2 )
{
var11 = var8 + var9;
var5 += var11 - var10;
var5 += level.br_level.br_circledelaytimes[ var6 ];
var12 = level.br_level.br_circleclosetimes[ var6 ];
var13 = level.br_level.default_class_chosen[ var6 ];
var14 = level.br_level.default_class_chosen[ var6 + 1 ];
var15 = level.br_level.br_circleradii[ var6 ];
var16 = level.br_level.br_circleradii[ var6 + 1 ];
}
else
{
if( var16 < var14 )
{
var6 += var14 - var16;
var12 = var15;
}
else
{
var12 = var16 - var12 - var15;
}

var13 = var12;
var14 = level.br_level.default_class_chosen[ var8 + 1 ];
var15 = var10;
var16 = level.br_level.br_circleradii[ var8 + 1 ];
}

var15 = float( var15 );
var16 = float( var16 );

if( var12 == 0 )
{
return var7;
}

var17 = var6[ 0 ];
var18 = var17 * var17;
var19 = var13[ 0 ];
var20 = var19 * var19;
var21 = ( var14[ 0 ] - var13[ 0 ] ) / var12;
var22 = var21 * var21;
var23 = var6[ 1 ];
var24 = var23 * var23;
var25 = var13[ 1 ];
var26 = var25 * var25;
var27 = ( var14[ 1 ] - var13[ 1 ] ) / var12;
var28 = var27 * var27;
var29 = var15;
var30 = var29 * var29;
var31 = ( var16 - var15 ) / var12;
var32 = var31 * var31;
var33 = sqrt( pow( 2 * var17 * var21 - 2 * var19 * var21 + 2 * var23 * var27 - 2 * var25 * var27 + 2 * var29 * var31, 2 ) - 4 * ( -1 * var22 - var28 + var32 ) * ( -1 * var18 + 2 * var17 * var19 - var20 - var24 + 2 * var23 * var25 - var26 + var30 ) );
var34 = -2 * var17 * var21 + 2 * var19 * var21 - 2 * var23 * var27 + 2 * var25 * var27 - 2 * var29 * var31;
var35 = 2 * ( -1 * var22 - var28 + var32 );

if( var35 == 0 )
{
return var7;
}

var36 = ( -1 * var33 + var34 ) / var35;
var37 = ( var33 + var34 ) / var35;

if( var36 < 0 )
{
var38 = var37;
}
else if( var38 < 0 )
{
var38 = var37;
}
else
{
var38 = min( var38, var38 );
}

var9 += var38;
return var9;
}

function spawn_carriable_at_struct()
{
if( !isDefined( level.br_circle ) || !isDefined( level.br_circle.dangercircleui ) )
{
return;
}

level.br_circle.dangercircleui.hidden++;
level.br_circle.dangercircleent.hidden++;
level notify( "update_circle_hide" );
}

function spawn_dummy_crate()
{
level.br_circle.safecircleui.hidden++;
level.br_circle.safecircleent.hidden++;
level notify( "update_circle_hide" );
}

function ref_13348()
{
var0 = level.br_circle.dangercircleent.hidden || level.br_circle.dangercircleent.hidden;
level.br_circle.dangercircleui.hidden--;
level.br_circle.dangercircleent.hidden--;
var1 = level.br_circle.dangercircleui.hidden || level.br_circle.dangercircleent.hidden;

if( var0 && !var1 )
{
level notify( "update_circle_hide" );
return;
}
}

function ref_1336f()
{
var0 = level.br_circle.safecircleui.hidden || level.br_circle.safecircleent.hidden;
level.br_circle.safecircleui.hidden--;
level.br_circle.safecircleent.hidden--;
var1 = level.br_circle.safecircleui.hidden || level.br_circle.safecircleent.hidden;

if( var0 && !var1 )
{
level notify( "update_circle_hide" );
return;
}
}

function ref_13322()
{
return scripts\mp\utility\game::round_vehicle_logic() == "mini" || scripts\mp\utility\game::round_vehicle_logic() == "mmp" || getdvarint( "scr_br_alt_mode_escape_skip_initial_circle", 0 ) || scripts\mp\utility\game::round_vehicle_logic() == "reveal" || isDefined( level.disable_heli_lights ) && level.disable_heli_lights.ref_14291 == 3 || getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) != 0;
}

function circletimer( var0 )
{
level endon( "game_ended" );
level endon( "br_ending_start" );

if( istrue( scripts\mp\gametypes\br_gametypes::ref_12e05( "circleTimer", var0 ) ) )
{
return;
}

level.br_circle.starttime = gettime();
level.br_circle.circleindex = var0;
var1 = var0 == 0;
var2 = var0 == level.br_level.br_circleclosetimes.size - 1;
var3 = level.br_level.br_circledelaytimes[ var0 ];
var4 = level.br_level.br_circleclosetimes[ var0 ];
var5 = level.br_level.br_circleradii[ var0 + 1 ];

if( ref_13322() )
{
setomnvar( "ui_br_circle_num", var0 );
}
else
{
setomnvar( "ui_br_circle_num", var0 + 1 );
}

thread scripts\mp\gametypes\br_gulag::circletimer( var0 );
scripts\mp\gametypes\br_gametypes::ref_12e05( "circleTimerNext", var0 );
thread delay_play_depart_vo( level );
var6 = level.br_level.default_class_chosen[ var0 + 1 ];
level.br_circle.centertarget = var6;
level.br_circle.safecircleent.origin = ( level.br_circle.centertarget[ 0 ], level.br_circle.centertarget[ 1 ], var5 );
level.respawnclosets = gathervalidspawnclosets( var6, var5 );
cleanupoutercrates();
gatheroutercrates( var6, var5 );
var7 = level.br_level.default_player_connect_black_screen[ var0 ];

if( var7 > 0 )
{
spawn_carriable_at_struct();
scripts\engine\utility::delaythread( var7, &ref_13348 );
}

var8 = level.br_level.default_suicidebomber_combat[ var0 ];

if( var8 > 0 )
{
spawn_dummy_crate();
scripts\engine\utility::delaythread( var8, &ref_1336f );
}

thread startuiclosetimer( level, var3, var1, var2 );
level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
level.br_circle.dangercircleui.origin = getdangercircleorigin() + ( 0, 0, getdangercircleradius() );
setstaticuicircles( var3, level.br_circle.safecircleui, level.br_circle.dangercircleui, var2 );

if( get_allykilled_alias( var0 ) )
{
if( var1 )
{
scripts\mp\gametypes\br_public::brleaderdialog( "first_circle", 1 );
}
else
{
scripts\mp\gametypes\br_public::brleaderdialog( "new_circle", 1 );
}
}

if( istrue( level.usegulag ) )
{
level thread scripts\mp\gametypes\br_gulag::transitioncircle( var5, var3 );
}

level notify( "br_circle_set", var0 + 1 );
wait var3;
level notify( "br_circle_started", var0 + 1 );
level.group_unset_jugg_standstill = 1;
setomnvar( "ui_hardpoint_timer", gettime() + int( var4 * 1000 ) );

if( get_allowed_vehicle_types_from_wave( var0 ) )
{
if( var2 )
{
scripts\mp\gametypes\br_public::brleaderdialog( "final_circle", 1 );
}
else
{
scripts\mp\gametypes\br_public::brleaderdialog( "circle_closing", 1 );
}

thread dialoguelines( var0 );
}

level.br_circle.safecircleui.origin = level.br_circle.safecircleent.origin;
level.br_circle.dangercircleui.origin = getdangercircleorigin() + ( 0, 0, getdangercircleradius() );
setclosinguicircle( int( var4 ), level.br_circle.safecircleent, level.br_circle.dangercircleui, var2 );
level.br_circle.dangercircleent brcirclemoveTo( level.br_circle.centertarget[ 0 ], level.br_circle.centertarget[ 1 ], var5, var4 );
thread scripts\mp\music_and_dialog::defcon_alarms_stop();
wait var4;

if( ref_12c72( var0 ) )
{
if( getdvarint( "scr_br_correct_cicle_post_move", 1 ) )
{
level.br_circle.dangercircleent.origin = ( level.br_circle.centertarget[ 0 ], level.br_circle.centertarget[ 1 ], var5 );
}
}

var9 = 5;

if( var9 > 0 && var0 < var9 )
{
scripts\mp\rank::addglobalrankxpmultiplier( 1.2, "cirlceMult_" + scripts\engine\utility::string( var0 ) );
scripts\mp\weaponrank::addweaponrankxpmultiplier( 1.2, "cirlceMult_" + scripts\engine\utility::string( var0 ) );
}

level.group_unset_jugg_standstill = 0;
cleanupouterspawnclosets( var6, var5 );
}

function delay_play_depart_vo( var0 )
{
level endon( "game_ended" );

if( var0 > 0 )
{
var1 = var0 - 1;
var2 = level.br_level.br_circleminimapradii[ var0 ];
var3 = level.br_level.br_circleminimapradii[ var1 ];

if( var2 == var3 )
{
return;
}

var4 = 0.05;
var5 = 2;
var6 = var5 / var4;
var7 = int( ( var3 - var2 ) / var6 );
var8 = level.br_level.br_circleminimapradii[ var1 ];

for( var9 = 0; var9 < var6 ; var9++ )
{
var8 -= var7;
setomnvar( "ui_br_minimap_radius", var8 );
wait var4;
}

setomnvar( "ui_br_minimap_radius", level.br_level.br_circleminimapradii[ var0 ] );
return;
}

setomnvar( "ui_br_minimap_radius", level.br_level.br_circleminimapradii[ var0 ] );
}

function cleanupouterspawnclosets( var0, var1 )
{
var2 = var1 * var1;

if( isDefined( level.revivetriggers ) )
{
foreach ( var4 in level.revivetriggers )
{
if( isDefined( var4 ) && distance2dsquared( var0, var4.trigger.origin ) > var2 )
{
var5 = gathervalidspawnclosets( var4.trigger.origin, var1 );

if( isDefined( var5 ) && var5.size > 0 )
{
var4.victim scripts\mp\teamrevive::relocatetrigger( var5[ 0 ].origin );
}
else
{
var4.victim scripts\mp\teamrevive::removetrigger( var6 );
}
}
}

return;
}
}

function gathervalidspawnclosets( var0, var1 )
{
if( isDefined( level.respawnclosets ) )
{
var2 = scripts\engine\utility::get_array_of_closest( var0, level.respawnclosets, undefined, undefined, var1 );
return var2;
}

return undefined;
}

function gatheroutercrates( var0, var1 )
{
var2 = var1 * var1;

foreach ( var4 in level.br_pickups.crates )
{
if( isDefined( var4 ) && distance2dsquared( var0, var4.origin ) > var2 )
{
level.br_pickups.outercrates[ level.br_pickups.outercrates.size ] = var4;
}
}
}

function cleanupoutercrates()
{
foreach ( var1 in level.br_pickups.outercrates )
{
if( isDefined( var1 ) && var1.curprogress == 0 )
{
var1 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
}
}

level.br_pickups.outercrates = [];
}

function can_man_turret( var0, var1 )
{
var2 = [];

for( var3 = 0; var3 < var1 ; var3++ )
{
var2 = var0;
}

return var2;
}

function can_killstreak_be_detected( var0, var1, var2, var3, var4, var5 )
{
var6 = [];

if( !isDefined( var3 ) )
{
var3 = 0;
}

if( !isDefined( var4 ) )
{
var4 = 0.5;
}

if( !isDefined( var5 ) )
{
var5 = 0.1;
}

if( !isDefined( var2 ) )
{
var2 = 0;
}

var7 = var3 / 3 + var4 / 2 + var5;

for( var8 = 0; var8 < var1 ; var8++ )
{
if( var2 )
{
var9 = var1 - var8 - 1;
}
else
{
var9 = var8;
}

var10 = ( var3 * ( 6 * var8 * var8 + 6 * var8 + 2 ) + 3 * var1 * ( 2 * var4 * var8 + var4 + 2 * var5 * var1 ) ) / 6 * var1 * var1 * var1;
var11 = var10 / var7;
var6 = var11 * var0;
}

return var6;
}

function open_teleport_room_door( var0, var1, var2, var3, var4, var5 )
{
if( !isDefined( var4 ) )
{
var4 = 0;
}

if( !isDefined( var5 ) )
{
var5 = 0;
}

if( !isarray( var0 ) )
{
var0 = [ var0 ];
}

if( !isarray( var1 ) )
{
var1 = can_man_turret( var1, var0.size );
}

if( !isarray( var2 ) )
{
var2 = can_man_turret( var2, var0.size );
}

if( !isarray( var3 ) )
{
var3 = can_man_turret( var3, var0.size );
}

if( !isarray( var4 ) )
{
var4 = can_man_turret( var4, var0.size );
}

if( !isarray( var5 ) )
{
var5 = can_man_turret( var5, var0.size );
}

var6 = level.br_level.br_circleradii[ level.br_level.br_circleradii.size - 1 ];
level.br_level.br_circleradii[ level.br_level.br_circleradii.size - 1 ] = undefined;

for( var7 = 0; var7 < var0.size ; var7++ )
{
var8 = level.br_level.br_circleradii.size;
level.br_level.br_circleradii[ var8 ] = var0[ var7 ];
var8 = level.br_level.br_circleclosetimes.size;
level.br_level.br_circleclosetimes[ var8 ] = var1[ var7 ];
var8 = level.br_level.br_circledelaytimes.size;
level.br_level.br_circledelaytimes[ var8 ] = var2[ var7 ];
var8 = level.br_level.br_circleminimapradii.size;
level.br_level.br_circleminimapradii[ var8 ] = var3[ var7 ];
var8 = level.br_level.default_player_connect_black_screen.size;
level.br_level.default_player_connect_black_screen[ var8 ] = var4[ var7 ];
var8 = level.br_level.default_suicidebomber_combat.size;
level.br_level.default_suicidebomber_combat[ var8 ] = var5[ var7 ];
}

level.br_level.br_circleradii[ level.br_level.br_circleradii.size ] = var6;
}

function last_vo_time( var0 )
{
level.br_level.br_circleradii = scripts\engine\utility::array_remove_index( level.br_level.br_circleradii, var0 );
level.br_level.br_circleclosetimes = scripts\engine\utility::array_remove_index( level.br_level.br_circleclosetimes, var0 );
level.br_level.br_circledelaytimes = scripts\engine\utility::array_remove_index( level.br_level.br_circledelaytimes, var0 );
level.br_level.br_circleminimapradii = scripts\engine\utility::array_remove_index( level.br_level.br_circleminimapradii, var0 );
level.br_level.default_player_connect_black_screen = scripts\engine\utility::array_remove_index( level.br_level.default_player_connect_black_screen, var0 );
level.br_level.default_suicidebomber_combat = scripts\engine\utility::array_remove_index( level.br_level.default_suicidebomber_combat, var0 );
}

function calculatebrbonusxp()
{
if( !getdvarint( "scr_br_moving_circle_enabled", 1 ) || scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "movingCircle" ) )
{
level.br_level.delay_start_escort_protect_hvi_objective = 0;
return;
}

level.br_level.delay_start_escort_protect_hvi_objective = getdvarint( "scr_br_moving_circle_count", 0 );
level.br_level.delay_start_player_weapon_fired_monitor = getdvarfloat( "scr_br_moving_circle_move_dist_min", 100 );
level.br_level.delay_start_player_grenade_fire_monitor = getdvarfloat( "scr_br_moving_circle_move_dist_max", 300 );
var0 = getdvarint( "scr_br_moving_circle_preset", 0 );
var1 = level.br_level.br_circleradii.size - 1;

switch ( var0 )
{
case 1:
if( !level.br_level.delay_start_escort_protect_hvi_objective )
{
level.br_level.delay_start_escort_protect_hvi_objective = 4;
}

var2 = level.br_level.br_circleradii[ var1 ];
var3 = level.br_level.br_circleradii[ var1 - 1 ];
var4 = level.br_level.br_circleclosetimes[ var1 - 1 ];
var5 = level.br_level.br_circledelaytimes[ var1 - 1 ];
var6 = level.br_level.br_circleminimapradii[ var1 - 1 ];
last_vo_time( var1 - 1 );
var7 = level.br_level.delay_start_escort_protect_hvi_objective;
var8 = getdvarvector( "scr_br_moving_circle_preset_auto_radius_distribution", ( 0, 1, 0 ) );
var9 = [];
var10 = can_killstreak_be_detected( var3 - var2, var7 + 1, 1, var8[ 0 ], var8[ 1 ], var8[ 2 ] );
var11 = 0;

for( var12 = 0; var12 < var7 ; var12++ )
{
var11 += var10[ var12 ];
var9 = var3 - var11;
}

var8 = getdvarvector( "scr_br_moving_circle_preset_auto_time_distribution", ( 0, 1, 0.125 ) );
var13 = getdvarfloat( "scr_br_moving_circle_preset_auto_time_scale", 1 );
var14 = getdvarfloat( "scr_br_moving_circle_preset_auto_time_ratio", 0.5 );
var15 = ( var4 + var4 ) * var13;
var16 = can_killstreak_be_detected( var15 * var14, var7, 1, var8[ 0 ], var8[ 1 ], var8[ 2 ] );
var17 = can_killstreak_be_detected( var15 * ( 1 - var14 ), var7, 1, var8[ 0 ], var8[ 1 ], var8[ 2 ] );
open_teleport_room_door( var9, var16, var17, var6 );
break;
case 2:
last_vo_time( var1 - 1 );
level.br_level.delay_start_escort_protect_hvi_objective = 4;
var9 = [ 1200, 900, 600, 300 ];
var16 = [ 30, 30, 30, 30 ];
var18 = [ 30, 20, 10, 0 ];
var19 = [ 5500, 5000, 4500, 4000 ];
open_teleport_room_door( var9, var16, var18, var19 );
break;
case 3:
level.br_level.delay_start_escort_protect_hvi_objective = 5;
var9 = [ 1200, 900, 600, 300 ];
var16 = [ 30, 30, 30, 30 ];
var18 = [ 30, 20, 10, 0 ];
var19 = [ 5500, 5000, 4500, 4000 ];
open_teleport_room_door( var9, var16, var18, var19 );
break;
case 4:
last_vo_time( var1 - 1 );
level.br_level.delay_start_escort_protect_hvi_objective = 4;
var20 = 1500;
var21 = 750 + randomint( 301 );
var22 = 1000 + randomint( 301 );
var9 = [ var20, var20, var21, var22 ];
var16 = [ 30, 30, 30, 45 ];
var18 = [ 10, 5, 5, 0 ];
var19 = [ 5500, 5500, 5500, 5500 ];
open_teleport_room_door( var9, var16, var18, var19 );
break;
case 5:
var2 = level.br_level.br_circleradii[ var1 ];
var3 = level.br_level.br_circleradii[ var1 - 1 ];
var4 = level.br_level.br_circleclosetimes[ var1 - 1 ];
var5 = level.br_level.br_circledelaytimes[ var1 - 1 ];
var6 = level.br_level.br_circleminimapradii[ var1 - 1 ];
last_vo_time( var1 - 1 );

if( !level.br_level.delay_start_escort_protect_hvi_objective )
{
level.br_level.delay_start_escort_protect_hvi_objective = 4;
}

var7 = level.br_level.delay_start_escort_protect_hvi_objective;
var8 = getdvarvector( "scr_br_moving_circle_preset_auto_radius_distribution", ( 0, 1, 0 ) );
var9 = [];
var10 = can_killstreak_be_detected( var3 - var2, var7 + 1, 1, var8[ 0 ], var8[ 1 ], var8[ 2 ] );
var11 = 0;

for( var12 = 0; var12 < var7 ; var12++ )
{
var11 += var10[ var12 ];
var9 = var3 - var11;
}

var23 = [ 3000, 2000, 1000, 500 ];

for( var12 = 0; var12 < var7 ; var12++ )
{
var9 = var9[ var12 ] + var23[ var12 ];
}

var8 = getdvarvector( "scr_br_moving_circle_preset_auto_time_distribution", ( 0, 1, 0.125 ) );
var13 = getdvarfloat( "scr_br_moving_circle_preset_auto_time_scale", 1 );
var14 = getdvarfloat( "scr_br_moving_circle_preset_auto_time_ratio", 0.5 );
var15 = ( var4 + var4 ) * var13;
var16 = can_killstreak_be_detected( var15 * var14, var7, 1, var8[ 0 ], var8[ 1 ], var8[ 2 ] );
var17 = can_killstreak_be_detected( var15 * ( 1 - var14 ), var7, 1, var8[ 0 ], var8[ 1 ], var8[ 2 ] );
open_teleport_room_door( var9, var16, var17, var6 );
break;
case 6:
level.br_level.delay_start_escort_protect_hvi_objective = 4;
var9 = [ 4200, 2200, 1300, 600 ];
var16 = [ 30, 30, 30, 30 ];
var18 = [ 30, 20, 10, 0 ];
var19 = [ 5500, 5000, 4500, 4000 ];
open_teleport_room_door( var9, var16, var18, var19 );
break;
case 0:
default:
break;
}

if( var0 )
{
var24 = level.br_level.br_circleradii.size - 1;
level.br_level.delay_start_infiltrate_objective = var24 - var1;
return;
}
}

function cachedomnars()
{
var0 = level.br_level;
var1 = var0.br_circleclosetimes.size;
var2 = var0.br_circleradii[ var1 ];
var3 = 0;

while( var3 < var1 + 1 )
{
var4 = "scr_br_circle_set_" + var3;
var5 = getDvar( var4, "" );

if( var5 == "" )
{
}
else
{
if( var5 == "delete" )
{
for( var6 = var3; var6 < var1 ; var6++ )
{
var0.br_circleradii[ var6 ] = undefined;
var0.br_circleclosetimes[ var6 ] = undefined;
var0.br_circledelaytimes[ var6 ] = undefined;
var0.br_circleminimapradii[ var6 ] = undefined;
var0.default_player_connect_black_screen[ var6 ] = undefined;
var0.default_suicidebomber_combat[ var6 ] = undefined;
}

var0.br_circleradii[ var3 ] = var2;
var0.br_circleradii[ var6 ] = undefined;
break;
}

var7 = "?";
var8 = strtok( var5, "," );

if( var3 >= var1 )
{
var9 = 6;
gulagindex( var8.size == var9, "Dvar: " + var4 + " has " + var8.size + " values, expected " + var9 );

if( var8.size != var9 )
{
break;
}

var10 = 1;

for( var8 = 0; var8 < var11 ; var8++ )
{
if( var7[ var8 ] == var5 )
{
var10 = 0;
break;
}
}

gulagindex( var10, "Dvar: " + var3 + " has requires all " + var11 + " values set" );

if( !var10 )
{
break;
}
}

for( var5 = 0; var5 < var4.size ; var5++ )
{
var7 = var4[ var5 ];

if( var7 == var3 )
{
continue;
}

switch ( var5 )
{
case 0:
<error>.br_circleradii[ var0 ] = int( var7 );
break;
case 1:
<error>.br_circleclosetimes[ var0 ] = int( var7 );
break;
case 2:
<error>.br_circledelaytimes[ var0 ] = int( var7 );
break;
case 3:
<error>.br_circleminimapradii[ var0 ] = int( var7 );
break;
case 4:
<error>.default_player_connect_black_screen[ var0 ] = int( var7 );
break;
case 5:
<error>.default_suicidebomber_combat[ var0 ] = int( var7 );
break;
default:
break;
}
}

if( var0 >= <error> )
{
<error>.br_circleradii[ var0 + 1 ] = <error>;
<error>++;
}
}

var0++;
}
}

function cacheentity()
{
calculatebrbonusxp();
cachedomnars();
var0 = getdvarfloat( "scr_br_circle_time_scale", 1 );
var1 = level.br_level;
var1.br_circleclosetimes = add_client_back_to_mask_after_delay( var1.br_circleclosetimes, "close_time", var0, 0 );
var1.br_circledelaytimes = add_client_back_to_mask_after_delay( var1.br_circledelaytimes, "delay_time", var0, 0 );
var1.default_player_connect_black_screen = add_client_back_to_mask_after_delay( var1.default_player_connect_black_screen, "show_delay_danger", var0, 1 );
var1.default_suicidebomber_combat = add_client_back_to_mask_after_delay( var1.default_suicidebomber_combat, "show_delay_safe", var0, 1 );

if( !isDefined( var1.default_compare ) )
{
var1.default_compare = level.br_level.br_circleradii[ 0 ];
}

cargo_truck_mg_cp_initlate();
}

function add_client_back_to_mask_after_delay( var0, var1, var2, var3 )
{
var4 = getdvarfloat( "scr_br_circle_" + var1 + "_scale", 1 );

for( var5 = 0; var5 < var0.size ; var5++ )
{
var6 = getdvarfloat( "scr_br_circle_override_" + var1 + "_" + var5, -1 );

if( var6 > 0 || var6 == 0 && var3 )
{
var0 = var6;
}

var0 = var0[ var5 ] * var2;
var0 = var0[ var5 ] * var4;
}

return var0;
}

function cargo_truck_mg_cp_initlate()
{
gulagindex( isDefined( level.br_level.br_circleclosetimes ), "level.br_level.br_circleCloseTimes not defined" );
gulagindex( isDefined( level.br_level.br_circledelaytimes ), "level.br_level.br_circleDelayTimes not defined" );
gulagindex( isDefined( level.br_level.default_player_connect_black_screen ), "level.br_level.br_circleShowDelayDanger not defined" );
gulagindex( isDefined( level.br_level.default_suicidebomber_combat ), "level.br_level.br_circleShowDelaySafe not defined" );
gulagindex( isDefined( level.br_level.br_circleminimapradii ), "level.br_level.br_circleMinimapRadii not defined" );
gulagindex( isDefined( level.br_level.br_circleradii ), "level.br_level.br_circleDelayTimes not defined" );
var0 = level.br_level.br_circleclosetimes.size;
gulagindex( var0 == level.br_level.br_circledelaytimes.size, "level.br_level.br_circleDelayTimes size != " + var0 );
gulagindex( var0 == level.br_level.default_player_connect_black_screen.size, "level.br_level.br_circleShowDelayDanger size != " + var0 );
gulagindex( var0 == level.br_level.default_suicidebomber_combat.size, "level.br_level.br_circleShowDelaySafe size != " + var0 );
gulagindex( var0 == level.br_level.br_circleminimapradii.size, "level.br_level.br_circleMinimapRadii size != " + var0 );
gulagindex( var0 == level.br_level.br_circleradii.size - 1, "level.br_level.br_circleRadii size-1 != " + var0 );

for( var1 = 0; var1 < level.br_level.default_player_connect_black_screen.size ; var1++ )
{
var2 = level.br_level.br_circledelaytimes[ var1 ];
gulagindex( isDefined( var2 ), "delayTime undefined for br_circleDelayTimes " + var1 );
var3 = level.br_level.default_player_connect_black_screen[ var1 ];
gulagindex( isDefined( var3 ), "showDelay undefined for br_circleShowDelayDanger " + var1 );
gulagindex( var3 <= var2, "level.br_level.br_circleShowDelayDanger[" + var1 + "] " + var2 + " > " + var3 );
}

for( var1 = 0; var1 < level.br_level.br_circledelaytimes.size ; var1++ )
{
var2 = level.br_level.br_circledelaytimes[ var1 ];
gulagindex( isDefined( var2 ), "delayTime undefined for br_circleDelayTimes " + var1 );
var3 = level.br_level.default_suicidebomber_combat[ var1 ];
gulagindex( isDefined( var3 ), "showDelay undefined for br_circleShowDelaySafe " + var1 );
gulagindex( var3 <= var2, "level.br_level.br_circleDelayTimes[" + var1 + "] " + var2 + " > " + var3 );
}

if( getdvarint( "scr_br_moving_circle_enabled", 1 ) && !scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "movingCircle" ) )
{
gulagindex( level.br_level.br_circleradii[ 0 ] == level.br_level.default_compare, "Changing circle radius 0 is not supported" );
return;
}
}

function gulagindex( var0, var1 )
{
if( !var0 )
{
return;
}
}

function relic_amped_pick_random_valid_player( var0 )
{
if( !isDefined( level.br_level ) )
{
return 0;
}

if( !isDefined( level.br_level.br_circledelaytimes ) || !level.br_level.br_circledelaytimes.size )
{
return 0;
}

var1 = level.br_level.br_circledelaytimes.size;

if( var0 >= var1 )
{
var0 = var1 - 1;
}

var2 = 0;

for( var3 = 0; var3 <= var0 ; var3++ )
{
var4 = level.br_level.br_circledelaytimes[ var3 ];
var5 = level.br_level.br_circleclosetimes[ var3 ];
var2 = var2 + var4 + var5;
}

return var2;
}

function dialoguelines( var0 )
{
var1 = level.br_level.br_circledelaytimes[ var0 ] / 5;
wait var1;

foreach ( var3 in level.teamnamelist )
{
var4 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic( var3 );

for( var5 = 0; var5 < var4.size ; var5++ )
{
var6 = var4[ var5 ];
thread maxtokensdropondeath( level, var3 );
}
}
}

function maxtokensdropondeath( var0, var1 )
{
var2 = getsafecircleorigin();
var3 = getsafecircleradius();
var4 = scripts\mp\gametypes\br_public::rotationrefsbyseatandweapon( var0, var1 );

if( var4.size <= 1 )
{
return;
}

var5 = sortbydistance( var4, var2 );
var6 = distance2dsquared( var2, var5[ 0 ].origin );

if( var6 > var3 * var3 )
{
if( var6 > var3 * var3 * 4 )
{
level thread scripts\mp\battlechatter_mp::trysaylocalsound( var5[ 0 ], "obj_sitrep_circle_outfar" );
return;
}

level thread scripts\mp\battlechatter_mp::trysaylocalsound( var5[ 0 ], "obj_sitrep_circle_out" );
return;
}

var7 = distance2dsquared( var2, var5[ var5.size - 1 ].origin );

if( var7 > var3 * var3 )
{
level thread scripts\mp\battlechatter_mp::trysaylocalsound( var5[ 0 ], "obj_sitrep_circle_mixed" );
return;
}

level thread scripts\mp\battlechatter_mp::trysaylocalsound( var5[ 0 ], "obj_sitrep_circle_in" );
}

function init_safehouse_gunshop( var0, var1 )
{
if( !isDefined( level.debug_vault_assault_retrieve_saw_obj_start ) )
{
level.debug_vault_assault_retrieve_saw_obj_start = [];
}

var2 = spawnStruct();
var2.origin = var0;
var2.radius = var1;
var2.ref_129e5 = var1 * var1;
return var2;
}

function get_allykilled_alias( var0 )
{
var1 = 1;
var2 = scripts\mp\utility\game::round_vehicle_logic();

if( var2 == "mini" || var2 == "rumble" || var2 == "kingslayer" || var2 == "zxp" || getdvarint( "scr_br_alt_mode_escape_skip_initial_circle", 0 ) || var2 == "reveal" || isDefined( level.disable_heli_lights ) && level.disable_heli_lights.ref_14291 == 3 || var2 == "x2" || getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) || scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "firstCircleVo" ) )
{
if( var0 <= 1 )
{
var1 = 0;
}
}

return var1;
}

function get_allowed_vehicle_types_from_wave( var0 )
{
var1 = 1;
var2 = scripts\mp\utility\game::round_vehicle_logic();

if( var2 == "reveal" || var2 == "x2" || var2 == "Rumble" )
{
var1 = 0;
return var1;
}

if( var2 == "mini" || var2 == "zxp" || getdvarint( "scr_br_alt_mode_escape_skip_initial_circle", 0 ) || isDefined( level.disable_heli_lights ) && level.disable_heli_lights.ref_14291 == 3 || getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) || scripts\mp\gametypes\br_gametypes::unset_relic_aggressive_melee( "firstCircleVo" ) )
{
if( var0 == 0 )
{
var1 = 0;
}
}

return var1;
}

function ref_12c72( var0 )
{
var1 = 0;
var2 = scripts\mp\utility\game::round_vehicle_logic();

switch ( var2 )
{
case "zxp":
case "mmp":
case "mini":
if( var0 == 0 )
{
var1 = 1;
}

break;
case "brdov":
if( level.disable_heli_lights.ref_14291 == 3 )
{
if( var0 == 0 )
{
var1 = 1;
}
}

break;
case "reveal":
var1 = 1;
break;
}

if( isDefined( level.obit_activation ) && getdvarint( "scr_br_alt_mode_escape_skip_initial_circle", 0 ) )
{
var1 = 1;
}

if( getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) != 0 && var0 == 0 )
{
var1 = 1;
}

return var1;
}

function teleport_entities_inside_subway_car( var0 )
{
setdvarifuninitialized( "scr_br_fc_circle_disable", 3 );
setdvarifuninitialized( "scr_br_circle_close_time_scale", 1 );
setdvarifuninitialized( "scr_br_circle_delay_time_scale", 1 );
setdvarifuninitialized( "scr_br_circle_show_delay_danger_scale", 1 );
setdvarifuninitialized( "scr_br_circle_show_delay_safe_scale", 1 );

for( var1 = 0; var1 < var0 ; var1++ )
{
setdvarifuninitialized( "scr_br_circle_override_close_time_" + var1, -1 );
setdvarifuninitialized( "scr_br_circle_override_delay_time_" + var1, -1 );
setdvarifuninitialized( "scr_br_circle_override_show_delay_danger_" + var1, -1 );
}
}

function init_relic_explodedmg( var0, var1, var2 )
{
if( !isDefined( var2 ) )
{
var2 = 5;
}

if( var1 > var0.size )
{
var1 = var0.size;
}

foreach ( var4 in var0 )
{
var0 = ( var4[ 0 ], var4[ 1 ], 0 );
}

var6 = scripts\engine\utility::array_randomize( getarraykeys( var0 ) );
var7 = [];

for( var8 = 0; var8 < var1 ; var8++ )
{
var9 = spawnStruct();
var9.origin = var0[ var6[ var8 ] ];
var9.heli_watch_for_fly_away = [];
var9.radius = 0;
var7 = var9;
}

for( var10 = 0; var10 < var2 ; var10++ )
{
for( var8 = 0; var8 < var1 ; var8++ )
{
var7[ var8 ].heli_watch_for_fly_away = [];
}

foreach ( var16, var12 in var0 )
{
var13 = 0;
var14 = distance2dsquared( var12, var7[ 0 ].origin );

for( var8 = 1; var8 < var7.size ; var8++ )
{
var15 = distance2dsquared( var12, var7[ var8 ].origin );

if( var15 < var14 )
{
var13 = var8;
var14 = var15;
}
}

var7[ var13 ].heli_watch_for_fly_away[ var16 ] = var0[ var16 ];
}

var17 = 0;

foreach ( var9 in var7 )
{
if( var9.heli_watch_for_fly_away.size == 0 )
{
continue;
}

var19 = ( 0, 0, 0 );

foreach ( var4 in var9.heli_watch_for_fly_away )
{
var19 += var4;
}

var19 /= var9.heli_watch_for_fly_away.size;

if( var19 != var9.origin )
{
var9.origin = var19;
var17 = 1;
}
}

if( !var17 )
{
break;
}
}

return var7;
}

function relic_focusfire_modifyplayerdamage( var0 )
{
var1 = [];

foreach ( var3 in level.players )
{
var1 = var3.origin;
}

[ var6 ] = init_relic_explodedmg( var1, var0 );

foreach ( var8 in var5 )
{
if( var8.heli_watch_for_fly_away.size > var6.heli_watch_for_fly_away.size )
{
var6 = var8;
}
}

return var6.origin;
}