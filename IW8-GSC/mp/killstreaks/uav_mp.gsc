/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\uav_mp.gsc
***********************************************/

init_uav_mp() {
  level.radarviewtime = 25;
  level.advradarviewtime = getdvarint("_encstr_813717635FA3BFB74381BDB11DF998908B3FB42A237FE07D07", 30);
  level.uavblocktime = 23;
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_851904B59B34", scripts\cp_mp\killstreaks\uav::tryuseuavfromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_8FFA10EB3033E5B2613B4D05176949BDF950", scripts\cp_mp\killstreaks\uav::tryuseuavfromstruct);
  level.uavsettings = [];
  level.uavsettings["_encstr_851904B59B34"] = spawnStruct();
  level.uavsettings["_encstr_851904B59B34"].timeout = level.radarviewtime;
  level.uavsettings["_encstr_851904B59B34"].health = 999999;
  level.uavsettings["_encstr_851904B59B34"].maxhealth = 450;
  level.uavsettings["_encstr_851904B59B34"].streakname = "_encstr_851904B59B34";
  level.uavsettings["_encstr_851904B59B34"].modelbase = "_encstr_A7921CD9CA4370F5ADD2C6FAB04B39BEB5B8D55926ACB172F5E66BC26336";
  level.uavsettings["_encstr_851904B59B34"].modelbasealt = "_encstr_813E21B53D4C92E0FFD2B0DE3A872EF1A5810B1BA2F7801B0F6BE801D24B70E8FEFB81";
  level.uavsettings["_encstr_851904B59B34"].fxid_explode = loadfx("_encstr_B14928D9663CBCB4EE0E7DB6835EDAA563B19B3A9CAC2CADE5679987FABA85ECAF19560B3A43B8D9CC87");
  level.uavsettings["_encstr_851904B59B34"].fx_leave_tag = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";
  level.uavsettings["_encstr_851904B59B34"].fxid_contrail = undefined;
  level.uavsettings["_encstr_851904B59B34"].fx_contrail_tag = undefined;
  level.uavsettings["_encstr_851904B59B34"].sound_explode = "_encstr_885A12DA38AF5DC2ECD7B2F0E0B1DEFA192DDC8E";
  level.uavsettings["_encstr_851904B59B34"].teamsplash = "_encstr_8F0A0960FB97193E0F81DC";
  level.uavsettings["_encstr_851904B59B34"].votimeout = "_encstr_A6C90C1D2DB5CABDBAD17DBA0BEC";
  level.uavsettings["_encstr_851904B59B34"].calloutdestroyed = "_encstr_8A4E16D1E6ACA0709B0367297FC3C598777899C9811D70B4";
  level.uavsettings["_encstr_851904B59B34"].addfunc = scripts\cp_mp\killstreaks\uav::addactiveuav;
  level.uavsettings["_encstr_851904B59B34"].removefunc = scripts\cp_mp\killstreaks\uav::removeactiveuav;
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"] = spawnStruct();
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].timeout = level.advradarviewtime;
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].health = 999999;
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].maxhealth = 2000;
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].streakname = "_encstr_8FFA10EB3033E5B2613B4D05176949BDF950";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].modelbase = "_encstr_B21E163B2BA170AF5B2DC6BEB05AE4F50BAEB92D99BD276B";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].modelbasealt = "_encstr_8BE11BAB1F284ACF19E35936693A02B7C6937EE384B84E326EC76003C9";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].fxid_explode = loadfx("_encstr_A1B0294DB4989758FBE27757837A43085419CABD92D04ABABD1B4512A979C51FC3A78943A2108CD8661A79");
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].fx_leave_tag = "_encstr_A2B40B8E2C3B7DDB274B9D4B37";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].fxid_contrail = undefined;
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].fx_contrail_tag = "_encstr_A3040E412FDAAFE0DDA32E434A81A0C1";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].sound_explode = "_encstr_885A12DA38AF5DC2ECD7B2F0E0B1DEFA192DDC8E";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].votimeout = "_encstr_9BB5184B03E71332DB691998DF0395086BC7E288826BD9E59B03";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].teamsplash = "_encstr_991115BA3795467D32A593958D8E2DBD9B85637DEA2CEC";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].calloutdestroyed = "_encstr_A2332277377281C0B5DB2659879B50C6FAFFE3F1371ADB10FD764BF02D7E20719157632D";
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].addfunc = scripts\cp_mp\killstreaks\uav::addactiveuav;
  level.uavsettings["_encstr_8FFA10EB3033E5B2613B4D05176949BDF950"].removefunc = scripts\cp_mp\killstreaks\uav::removeactiveuav;
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(scripts\cp_mp\killstreaks\uav::onplayerspawned);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_851904B59B34", "_encstr_924B1EBBB0434D43212DC12EC06B939587181323A133075719ADC903EE10EF1B", scripts\mp\killstreaks\remoteuav::remoteuav_processtaggedassist);
}