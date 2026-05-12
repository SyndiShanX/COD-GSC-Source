/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_dlc4_vo.gsc
*********************************************/

func_5366() {
  level endon("game_ended");
  maps\mp\_utility::func_3FA3("intro_vo_complete", 0);
  waittillframeend;
  waittillframeend;
  if(!game["switchedsides"]) {
    game["voice"]["allies"] = "al_war_";
    game["voice"]["axis"] = "ax_war_";
  } else {
    game["voice"]["allies"] = "ax_war_";
    game["voice"]["axis"] = "al_war_";
  }

  game["dialog"] = [];
  game["dialog"]["lockouts"] = [];
  lib_0506::func_52C0();
  game["dialog"]["offense_obj"] = "headsuptroopsthisoperatio";
  game["dialog"]["defense_obj"] = "theallieshavediscoveredth";
  game["dialog"]["attacker_breach_start"] = "getsomecompositionbonthos_alt";
  game["dialog"]["attacker_breach_nag1"] = "getoneofthosebarricadesdo";
  game["dialog"]["attacker_breach_nag2"] = "pushitsoldiersbreachthatb";
  game["dialog"]["attacker_breach_nag3"] = "getinsidethatfacilitymove";
  game["dialog"]["attacker_breach_nag4"] = "breachoneofthebarricades";
  game["dialog"]["attacker_breach_nag5"] = "getabombonthosebarricades";
  game["dialog"]["attacker_breach_progress1"] = "bombactiveononeofthebarri";
  game["dialog"]["attacker_breach_progress2"] = "wevegotabombonthebarricad";
  game["dialog"]["attacker_breach_progress3"] = "weplantedabombononeoftheb";
  game["dialog"]["attacker_breach_defend1"] = "defendthatbombsoldier";
  game["dialog"]["attacker_breach_defend2"] = "youhavetokeepthekrautsawa";
  game["dialog"]["attacker_breach_defend3"] = "protectthebombatallcosts";
  game["dialog"]["attacker_breach_defend4"] = "dontletthegermansdefuseth";
  game["dialog"]["attacker_breach_defend5"] = "protectthebombuntilitdeto";
  game["dialog"]["attacker_breach_defuse1"] = "theenemyhasdefusedourbomb";
  game["dialog"]["attacker_breach_defuse2"] = "bombdefusedgetmorecompbon";
  game["dialog"]["attacker_breach_defuse3"] = "bombdefusedregroupandtrya";
  game["dialog"]["attacker_breach_overtime1"] = "outoftimebreachthefacilit";
  game["dialog"]["attacker_breach_overtime2"] = "lastchancemovemove";
  game["dialog"]["attacker_breach_overtime3"] = "holdthembackjustalittlelo";
  game["dialog"]["attacker_breach_success"] = "wevebrokenintothefacility";
  game["dialog"]["attacker_breach_failure"] = "wefailedtobreachthefacili";
  game["dialog"]["defender_breach_start"] = "defendtheresearchfacility";
  game["dialog"]["defender_breach_nag1"] = "defendtheentrances";
  game["dialog"]["defender_breach_nag2"] = "dontletthembreachtheentra";
  game["dialog"]["defender_breach_nag3"] = "protecttheentrancetothefa";
  game["dialog"]["defender_breach_nag4"] = "wemustholdthembackdefendt_alt";
  game["dialog"]["defender_breach_nag5"] = "keepthefacilitysealed";
  game["dialog"]["defender_breach_progress1"] = "abombhasbeenplantedononeo_alt";
  game["dialog"]["defender_breach_progress2"] = "explosivesplantedonthebar";
  game["dialog"]["defender_breach_progress3"] = "theyveplantedexplosiveson_alt";
  game["dialog"]["defender_breach_defend1"] = "defusethebombbeforeitdeto";
  game["dialog"]["defender_breach_defend2"] = "getinthereandstopthatbomb";
  game["dialog"]["defender_breach_defend3"] = "youmustdefusethebomboritw";
  game["dialog"]["defender_breach_defend4"] = "quicklydefusethebomb";
  game["dialog"]["defender_breach_defend5"] = "youmuststopthatbombimmedi";
  game["dialog"]["defender_breach_defuse1"] = "wevedefusedtheirbomb";
  game["dialog"]["defender_breach_defuse2"] = "bombdefused";
  game["dialog"]["defender_breach_defuse3"] = "theirexplosivehavebeendef";
  game["dialog"]["defender_breach_overtime1"] = "protectthebarricades";
  game["dialog"]["defender_breach_overtime2"] = "theymustnotgetinholdthem";
  game["dialog"]["defender_breach_overtime3"] = "finalstandsoldiersholdthe";
  game["dialog"]["defender_breach_success"] = "theybreachedtheresearchfa";
  game["dialog"]["defender_breach_failure"] = "wehavedefendedourposition";
  game["dialog"]["attacker_acquire_tech_start"] = "wehavetocapturethegermans";
  game["dialog"]["attacker_acquire_tech_nag1"] = "gettheweaponandschematics";
  game["dialog"]["attacker_acquire_tech_nag2"] = "grabthatweaponanddocument";
  game["dialog"]["attacker_acquire_tech_nag3"] = "moveitsoldiersgetthoseite";
  game["dialog"]["attacker_acquire_tech_nag4"] = "acquiretheweaponandschema";
  game["dialog"]["attacker_acquire_tech_nag5"] = "pushitsoldiersgettheweapo";
  game["dialog"]["attacker_acquire_tech_pickup11"] = "wevetakentheweapon";
  game["dialog"]["attacker_acquire_tech_pickup12"] = "wehavetheweapon";
  game["dialog"]["attacker_acquire_tech_pickup13"] = "theweaponisinourhandsgeti";
  game["dialog"]["attacker_acquire_tech_pickup14"] = "wehavethesecretweapon";
  game["dialog"]["attacker_acquire_tech_pickup15"] = "weaponhasbeenpickedupgeti";
  game["dialog"]["attacker_acquire_tech_dropped11"] = "weaponinthefieldgetit";
  game["dialog"]["attacker_acquire_tech_dropped12"] = "theweaponisontheground";
  game["dialog"]["attacker_acquire_tech_dropped13"] = "weapondroppedgetitback";
  game["dialog"]["attacker_acquire_tech_dropped14"] = "welosttheweapongetitback";
  game["dialog"]["attacker_acquire_tech_dropped15"] = "getthatweaponbacksoldiers";
  game["dialog"]["attacker_acquire_tech_returned11"] = "theyreturnedtheweapon";
  game["dialog"]["attacker_acquire_tech_returned12"] = "theweaponisbackinenemyhan";
  game["dialog"]["attacker_acquire_tech_returned13"] = "enemygottheirweaponback";
  game["dialog"]["attacker_acquire_tech_returned14"] = "theygotthegunbackpushhard";
  game["dialog"]["attacker_acquire_tech_returned15"] = "theirgunhasbeenreturned";
  game["dialog"]["attacker_acquire_tech_pickup21"] = "wehavethetechplans";
  game["dialog"]["attacker_acquire_tech_pickup22"] = "theplansareinalliedhandsd";
  game["dialog"]["attacker_acquire_tech_pickup23"] = "wehavetheschematics";
  game["dialog"]["attacker_acquire_tech_pickup24"] = "gottheschematics";
  game["dialog"]["attacker_acquire_tech_pickup25"] = "wehavethedocuments";
  game["dialog"]["attacker_acquire_tech_dropped21"] = "documentsareontheground";
  game["dialog"]["attacker_acquire_tech_dropped22"] = "welosttheschematicsgetemb";
  game["dialog"]["attacker_acquire_tech_dropped23"] = "theschematicsarelostgetth";
  game["dialog"]["attacker_acquire_tech_dropped24"] = "droppedthetechplans";
  game["dialog"]["attacker_acquire_tech_dropped25"] = "techplansinthefieldpickth";
  game["dialog"]["attacker_acquire_tech_returned21"] = "thekrautsreturnedthedocs";
  game["dialog"]["attacker_acquire_tech_returned22"] = "thedocsarebackinaxishands";
  game["dialog"]["attacker_acquire_tech_returned23"] = "theygottheirschematicsbac";
  game["dialog"]["attacker_acquire_tech_returned24"] = "schematicshavebeenreturne";
  game["dialog"]["attacker_acquire_tech_returned25"] = "thetechdocshavebeenreturn";
  game["dialog"]["attacker_acquire_tech_delivery1"] = "weaponsecuredgoodwork";
  game["dialog"]["attacker_acquire_tech_delivery2"] = "schematicsaresecurenicejo";
  game["dialog"]["attacker_acquire_tech_overtime1"] = "wereoutoftimemoveitsoldie";
  game["dialog"]["attacker_acquire_tech_overtime2"] = "wereoutoftimemoveitsoldie";
  game["dialog"]["attacker_acquire_tech_overtime3"] = "wereoutoftimemoveitsoldie";
  game["dialog"]["attacker_acquire_tech_success"] = "wehavetheweaponandthetech";
  game["dialog"]["attacker_acquire_tech_failure"] = "wevefailedwedonthavetheit";
  game["dialog"]["defender_acquire_tech_start"] = "theenemymustnotbeallowedt";
  game["dialog"]["defender_acquire_tech_nag1"] = "defendourtechnology";
  game["dialog"]["defender_acquire_tech_nag2"] = "holdthembackprotectourwea";
  game["dialog"]["defender_acquire_tech_nag3"] = "donotletthemstealourweapo";
  game["dialog"]["defender_acquire_tech_nag4"] = "protectthedocumentsandwea";
  game["dialog"]["defender_acquire_tech_nag5"] = "holdthemoffdefendourtechn";
  game["dialog"]["defender_acquire_tech_pickup11"] = "theyvegotourweapon";
  game["dialog"]["defender_acquire_tech_pickup12"] = "theyvetakenoursecretweapo";
  game["dialog"]["defender_acquire_tech_pickup13"] = "theyhaveourprototypeweapo";
  game["dialog"]["defender_acquire_tech_pickup14"] = "theyvestolenthesecretweap";
  game["dialog"]["defender_acquire_tech_pickup15"] = "ourweaponhasbeentaken";
  game["dialog"]["defender_acquire_tech_dropped11"] = "weaponisonthegroundgetitb";
  game["dialog"]["defender_acquire_tech_dropped12"] = "theydroppedtheweapon";
  game["dialog"]["defender_acquire_tech_dropped13"] = "weaponisonthefieldgetit";
  game["dialog"]["defender_acquire_tech_dropped14"] = "theweaponhasbeendroppedre";
  game["dialog"]["defender_acquire_tech_dropped15"] = "theylosttheweponpickitup";
  game["dialog"]["defender_acquire_tech_returned11"] = "theweaponissafe";
  game["dialog"]["defender_acquire_tech_returned12"] = "thesecretweaponisbackinou";
  game["dialog"]["defender_acquire_tech_returned13"] = "wevegotourweaponback";
  game["dialog"]["defender_acquire_tech_returned14"] = "wevegottheweapon";
  game["dialog"]["defender_acquire_tech_returned15"] = "oursecretweaponhasbeenret";
  game["dialog"]["defender_acquire_tech_pickup21"] = "theyhaveourschematics";
  game["dialog"]["defender_acquire_tech_pickup22"] = "ourschematicshavebeentake";
  game["dialog"]["defender_acquire_tech_pickup23"] = "theyvestolentheschematics";
  game["dialog"]["defender_acquire_tech_pickup24"] = "theallieshavetakenthedocu";
  game["dialog"]["defender_acquire_tech_pickup25"] = "ourplansareinenemyhandsst";
  game["dialog"]["defender_acquire_tech_dropped21"] = "theschematicshavebeendrop";
  game["dialog"]["defender_acquire_tech_dropped22"] = "theyvelostthedocumentsget";
  game["dialog"]["defender_acquire_tech_dropped23"] = "thedocumentsareonthegroun";
  game["dialog"]["defender_acquire_tech_dropped24"] = "theyvedroppedtheschematic";
  game["dialog"]["defender_acquire_tech_dropped25"] = "gettheschematicsback";
  game["dialog"]["defender_acquire_tech_returned21"] = "thedocumentshavebeenretur";
  game["dialog"]["defender_acquire_tech_returned22"] = "wehavetheschematicsback";
  game["dialog"]["defender_acquire_tech_returned23"] = "theweaponsschematicsaresa";
  game["dialog"]["defender_acquire_tech_returned24"] = "wevegottheplansback";
  game["dialog"]["defender_acquire_tech_returned25"] = "wevereturnedtheschematics";
  game["dialog"]["defender_acquire_tech_delivery1"] = "theyvecapturedtheweapon";
  game["dialog"]["defender_acquire_tech_delivery2"] = "thedocmuentshavebeencaptu";
  game["dialog"]["defender_acquire_tech_overtime1"] = "timeisalmostupprotectthet";
  game["dialog"]["defender_acquire_tech_overtime2"] = "timeisalmostupprotectthet";
  game["dialog"]["defender_acquire_tech_overtime3"] = "timeisalmostupprotectthet";
  game["dialog"]["defender_acquire_tech_success"] = "theyvecapturedtheweaponan";
  game["dialog"]["defender_acquire_tech_failure"] = "weveheldoffthealliedattac2";
  game["dialog"]["attacker_escort_start"] = "weneedtoescortourtankwhil";
  game["dialog"]["attacker_escort_nag1"] = "staynearthattanksoldiers";
  game["dialog"]["attacker_escort_nag2"] = "escortthetankweneedtotake";
  game["dialog"]["attacker_escort_nag3"] = "getthattankmovingstaynear";
  game["dialog"]["attacker_escort_nag4"] = "moveitsoldiersgetthattank";
  game["dialog"]["attacker_escort_nag5"] = "keepthosekrautsoffourtank";
  game["dialog"]["attacker_escort_progress1"] = "advancingkeeptheenemyback";
  game["dialog"]["attacker_escort_progress2"] = "movingforward";
  game["dialog"]["attacker_escort_progress3"] = "movingupkeepthewayclear";
  game["dialog"]["attacker_escort_retreat1"] = "fallingbacknoonesnearby";
  game["dialog"]["attacker_escort_retreat2"] = "backingupgetsomesoldierso";
  game["dialog"]["attacker_escort_retreat3"] = "ourtankisaloneitspullingb";
  game["dialog"]["attacker_escort_destroy1"] = "gotonebutthemainbatteryis";
  game["dialog"]["attacker_escort_destroy2"] = "goodkeepadvancingtothechu";
  game["dialog"]["attacker_escort_destroy3"] = "alrightletsgettothechurch";
  game["dialog"]["attacker_escort_overtime1"] = "gettothetanknow";
  game["dialog"]["attacker_escort_overtime2"] = "moveitsoldierstimesupgett";
  game["dialog"]["attacker_escort_overtime3"] = "getthattankmovinglastchan";
  game["dialog"]["attacker_escort_success"] = "missionaccomplishedallwea";
  game["dialog"]["attacker_escort_failure"] = "theystoppedourtanktheirte";
  game["dialog"]["defender_escort_start"] = "wemustnotallowtheenemytoe";
  game["dialog"]["defender_escort_nag1"] = "stoptheirtank";
  game["dialog"]["defender_escort_nag2"] = "holdthelinedontlettheirta";
  game["dialog"]["defender_escort_nag3"] = "theymustnotmovetheirtankd";
  game["dialog"]["defender_escort_nag4"] = "holdyourgroundstopthealli";
  game["dialog"]["defender_escort_nag5"] = "keepthemawayfromthetank";
  game["dialog"]["defender_escort_progress1"] = "theirtankispushingforward";
  game["dialog"]["defender_escort_progress2"] = "thetankismoving";
  game["dialog"]["defender_escort_progress3"] = "thetankisadvancing";
  game["dialog"]["defender_escort_retreat1"] = "theirtankisretreating";
  game["dialog"]["defender_escort_retreat2"] = "theirtankhasbeenstopped";
  game["dialog"]["defender_escort_retreat3"] = "thetankispullingback";
  game["dialog"]["defender_escort_destroy1"] = "theydestroyedoneofourcann";
  game["dialog"]["defender_escort_destroy2"] = "dontletthemdestroyourcann";
  game["dialog"]["defender_escort_destroy3"] = "keepthemfromdestroyingthe";
  game["dialog"]["defender_escort_overtime1"] = "stopthemnow";
  game["dialog"]["defender_escort_overtime2"] = "getthealliesawayfromtheta";
  game["dialog"]["defender_escort_overtime3"] = "shootthealliesnearthetank";
  game["dialog"]["defender_escort_success"] = "theyvedestroyedallofourex";
  game["dialog"]["defender_escort_failure"] = "wevewontheenemyisinfullre";
  game["dialog"]["attacker_2min"] = "2minutesleftuntilenemyrei";
  game["dialog"]["attacker_1min"] = "in1minuteenemyreinforceme";
  game["dialog"]["attacker_30sec"] = "30secondsleft";
  game["dialog"]["attacker_10sec"] = "wererunningoutoftime10sec";
  game["dialog"]["defender_2min"] = "2minutesleftuntilourreinf";
  game["dialog"]["defender_1min"] = "1minuteleftkeepfighting";
  game["dialog"]["defender_30sec"] = "30secondsuntilourreinforc";
  game["dialog"]["defender_10sec"] = "10secondsleft";
  game["dialog"]["raid_ss_serum_a"] = "ss_serum_a_achieve";
  game["dialog"]["axis_friendly_raid_ss_serum_a_inbound"] = "ss_serum_a_allyuse";
  game["dialog"]["axis_enemy_raid_ss_serum_a_inbound"] = "ss_serum_a_enemyuse";
  game["dialog"]["raid_ss_serum_b"] = "ss_serum_b_achieve";
  game["dialog"]["axis_friendly_raid_ss_serum_b_inbound"] = "ss_serum_b_allyuse";
  game["dialog"]["axis_enemy_raid_ss_serum_b_inbound"] = "ss_serum_b_enemyuse";
  game["dialog"]["raid_ss_serum_c"] = "ss_serum_c_achieve";
  game["dialog"]["axis_friendly_raid_ss_serum_c_inbound"] = "ss_serum_c_allyuse";
  game["dialog"]["axis_enemy_raid_ss_serum_c_inbound"] = "ss_serum_c_enemyuse";
  game["dialog"]["raid_superweapon"] = "ss_raid_superweapon_achieve";
  game["dialog"]["allies_friendly_raid_superweapon_inbound"] = "ss_raid_superweapon_allyuse";
  game["dialog"]["allies_enemy_raid_superweapon_inbound"] = "ss_raid_superweapon_enemyuse";
  game["dialog"]["raid_tesla_moon"] = "ss_raid_superweapon_achieve";
  game["dialog"]["allies_friendly_raid_tesla_moon_inbound"] = "ss_raid_superweapon_allyuse";
  game["dialog"]["allies_enemy_raid_tesla_moon_inbound"] = "ss_raid_superweapon_enemyuse";
}

func_7FDF() {
  level endon("game_ended");
  waittillframeend;
  maps\mp\_utility::func_3FA5("prematch_done");
  runbreachvo();
  runacquiretechvo();
  runescortvo();
}

runbreachvo() {
  if(maps\mp\_utility::func_3FA0("started_vignettes")) {
    maps\mp\_utility::func_3FA5("finished_intro_vignette_allies");
  } else {}

  var_00 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_00, "breach", lib_04FF::func_6937("breach"));
  thread runbreachdefusevo(lib_04FF::func_6937("breach"), "breach_01");
  thread runbreachdefusevo(lib_04FF::func_6937("breach"), "breach_02");
  lib_0506::func_A61C("breach", "breach_start", 0.5);
  lib_04FF::func_6982("breach");
  lib_0506::func_A61A("breach_success");
}

runacquiretechvo() {
  level.intelobjectivevoplayedcount = 0;
  lib_0506::func_A61C("acquire_tech", "acquire_tech_start", 0.5);
  var_00 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_00, "acquire_tech", lib_04FF::func_6937("acquire_tech"));
  lib_04FF::func_6982("acquire_tech");
  lib_0506::func_A61A("acquire_tech_success");
}

runescortvo() {
  var_00 = maps\mp\gametypes\_gamelogic::func_46E5() / 1000;
  thread lib_0506::func_7FE0(var_00, "escort", lib_04FF::func_6937("tank_escort"));
  lib_0506::func_A61C("tank_escort", "escort_start", 0.5);
  lib_04FF::func_6982("tank_escort");
  thread lib_0506::func_A619("escort_success", 0.5);
}

func_A617(param_00, param_01, param_02) {
  var_03 = 8000;
  if(level.var_3F9D) {
    return;
  }

  if(!isDefined(level.var_7917)) {
    level.var_7917 = 0;
    level.var_7916 = "";
  }

  if(level.var_7917 < gettime() || param_00 != level.var_7916) {
    switch (param_00) {
      case "breach_02":
      case "breach_01":
        if(param_01 == "bomb_planted") {
          thread lib_0506::func_A61B("breach_progress", 1);
        }
        break;

      case "acquire_tech":
        if(param_01 == "delivery") {
          level.intelobjectivevoplayedcount++;
          if(param_02 == 1) {
            level notify("unlockSecretWeapon");
          }

          if(level.intelobjectivevoplayedcount > 1) {
            return;
          }

          thread lib_0506::func_A619("acquire_tech_delivery" + param_02);
        } else if(param_01 == "progress") {
          thread lib_0506::func_A61B("acquire_tech_pickup" + param_02, undefined, undefined, 5);
        } else if(param_01 == "dropped") {
          thread lib_0506::func_A61B("acquire_tech_dropped" + param_02, undefined, undefined, 5);
        } else if(param_01 == "returned") {
          thread lib_0506::func_A61B("acquire_tech_returned" + param_02, undefined, undefined, 5);
        }
        break;

      case "tank_escort":
        if(param_01 == "forward") {
          level.var_7917 = gettime() + var_03;
          thread lib_0506::func_A61B("escort_progress");
        } else if(param_01 == "reverse") {
          level.var_7917 = gettime() + var_03;
          thread lib_0506::func_A61B("escort_retreat");
        }
        break;

      default:
        break;
    }

    level.var_7916 = param_00;
  }
}

runbreachdefusevo(param_00, param_01) {
  level endon(param_00);
  var_02 = 1;
  var_03 = common_scripts\utility::func_46B5(param_01, "targetname");
  for(;;) {
    var_03 waittill("bomb_defused");
    thread lib_0506::func_A618("breach_defuse" + var_02, 1);
    var_02++;
    if(var_02 > 3) {
      var_02 = 1;
    }
  }
}