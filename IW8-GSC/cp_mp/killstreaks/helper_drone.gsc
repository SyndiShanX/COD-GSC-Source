/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\helper_drone.gsc
***********************************************/

init() {
  level.helperdronesettings = [];
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"] = spawnStruct();
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].timeout = 45.0;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].maxhealth = 30;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].hitstokill = 3;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].speed = 140;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].accel = 20;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].halfsize = 27;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].spawndist = 30;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].streakname = "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC";
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].vehicleinfo = "_encstr_9A351928CA841FEB2FD40786974393376D52E9B0629E87A0FFF597";
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].modelbase = "_encstr_8C1519D3C333875F90D8F531F198BA491963231BB3F07B552880ED";
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].teamsplash = "_encstr_82F017A377F30A076366E961D8B63F5E5A30629830F7EA3F15";
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].destroyedsplash = "_encstr_81472423CE59782883AB97F3CFCBC3FB2AF83DD50FF3919B33864F31FB8F08F34FFDC08B9A5B";
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].fxid_explode = loadfx("_encstr_8A7A3054A580A84810DA114F33FD5A8493102BC3F3F7F14ACEC005A0F6A913887E19474B8810EB350F2C191DBB135D831868");
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].sound_explode = "_encstr_A90A146AD31BC59B88A113CA88FD273FB061FCCF79E8";
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].vodestroyed = "_encstr_83581AC48563C6EB8C27BDB959BE1385D8B5EA83D746596E479CDBF2";
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].votimedout = "_encstr_A3201A6E497532692C0BD75D7AA602F34FEC036FF70B9BFD1DA783D3";
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].scorepopup = "_encstr_AAC71C1956B9E8277B5E5923D7C916C85839D791C9F6B9567DE4ACC6F637";
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].playfxcallback = ::helperdronefx;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].primarymode = "_encstr_849007B069FD0B5FDC";
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].primarymodestring = &"_encstr_8D7D1DC9B7DC042FC1EAD5CFB469EF4C7113B99146BABD4959C5DF401B2081";
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].primarymodefunc = ::setreconmodesettings;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].premoddamagefunc = undefined;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].postmoddamagefunc = ::helperdrone_modifydamageresponse;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].deathfunc = ::helperdronedestroyed;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].deployweaponname = "_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E";
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"]._id_11B06 = 1;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"]._id_11B07 = 1;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"]._id_11B17 = 3062500;
  level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"]._id_11B18 = 6250000;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"] = spawnStruct();
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].timeout = 45.0;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].maxhealth = 700;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].hitstokill = 3;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].speed = 100;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].accel = 10;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].halfsize = 50;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].spawndist = 100;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].streakname = "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60";
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].vehicleinfo = "_encstr_ACB51D13E1E059EAB8B99E7309790298D6FFA770E4D2B268A91BC9CA07B577";
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].modelbase = "_encstr_AA151CCE56A11CFA6B5A63D7B09693D7B5E2D5B289B26C837DCDD60B3663";
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].modelbasealt = "_encstr_A79E214BA788CA79182BF266CEABB81728AA834BAA77F6E86F92D85FF411772F1A7724";
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].teamsplash = "_encstr_8F881BABDCCA32AF4E2C8C584EF5199CBDDCACFABD9D594EEE2CD13686";
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].destroyedsplash = "_encstr_8CEE281FB9CDB0781F835639FA6FAD18A509AB991FB2103577FB2E21B3C76868F1670503DA5B68059772";
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].fxid_explode = loadfx("_encstr_8FC232BE050805776CDA113AFB68A74C40E933248558DE37380BBA73E6909B07E877D9AC3F58E9F7BBA3120A4BFBC73DA2ED5618");
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].sound_explode = "_encstr_8C69148BD2530F2861D44D7FF6D779C58B5BC0D06A8F";
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].vodestroyed = "_encstr_A3FD20BCB13B2340EDE905F2F62A0E5B2F16014B534FFEAD8ED053DFCD74AFDB17F9";
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].votimedout = "_encstr_88FE1E1C6B758A88830857D28F01175B7149DBB892A511872E8B237C576B5FF0";
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].scorepopup = "_encstr_A3FD20BCB13B2340EDE905F2F62A0E5B2F16014B534FFEAD8ED053DFCD74AFDB17F9";
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].playfxcallback = ::helperdronefx;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].fxid_light1 = [];
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].fxid_light1["_encstr_88BF06FD784A6393"] = loadfx("_encstr_95A4327B90AA879A6F8EE70D7939169BD068ABE7980305625F267D53D4F1E9547848336329797D7BBFB0F6CB48CDA1E22090B397");
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].fxid_light1["_encstr_ACFC091AE8AB2FCBE15119"] = loadfx("_encstr_B45B2316ADA0ADDFDB1B4A768D233FB41877B5812520C9BB7170923A4E8C13AC38ED341C63");
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].standupoffset = 120;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].crouchupoffset = 80;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].proneupoffset = 46;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].backoffset = 124;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].sideoffset = 55;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].primarymode = "_encstr_BD11062A9599F991";
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].primarymodestring = &"_encstr_82DF1CB0038D415E0B92AB37DC127101A178BFABE59167E7595907834182";
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].primarymodefunc = ::setoverwatchmodesettings;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].premoddamagefunc = undefined;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].postmoddamagefunc = ::helperdrone_modifydamagestates;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].deathfunc = ::helperdronedestroyed;
  level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].deployweaponname = "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039";
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"] = spawnStruct();
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].timeout = 45.0;
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].maxhealth = 300;
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].speed = 140;
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].accel = 20;
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].halfsize = 50;
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].spawndist = 100;
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].streakname = "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD";
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].vehicleinfo = "_encstr_A6D11D8B05748933C2C019682DCBDD8A390D6E1AF09AD14F631F93914193C1";

  if(level.gametype == "_encstr_B607038AAB")
    level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].modelbase = "_encstr_8A01198349D30A39982B6C57D350BA4F8EE3BAFAB1386BED31258A";
  else {
    level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].modelbase = "_encstr_95881635BDCC12607F52305EBA07AE71A605BD8326F588B1";
    level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].modelbasealt = "_encstr_938C1B5B6980F84901631BDF5B3BA32770F3D564E1607A227003375769";
  }

  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].teamsplash = "_encstr_92C41B5D6E9546D7DCC64E2C6B4C8DCA93FA9193F69BACFAECAB2C9C8C";
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].destroyedsplash = "_encstr_A24528B185B163B757E8EB32B2DCE8E4DBF2B223D7DCC6E4165B311B2B4EFAC8C9ED73CAD7D9AB0B3991";
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].fxid_explode = loadfx("_encstr_85342DE0CB28A89B333098993AEEC728945B406873CDB9579ECB0C1BD9B23D50CE179960B7735307C2707F086BAA51");
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].sound_explode = "_encstr_BD8618CDD8E42CD63163B293EB19E4DE37B2D72BE11C8D7BC856";
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].vodestroyed = "_encstr_B62F20F14D3A5B3298314F941F8348B390D9F6D2851AB94343B8B62209202D5BD55B";
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].votimedout = "_encstr_A2AF1E8E4BDA2BBDAE47D76E6CC9586B263659E4EB9127BD3756AFD9BAC2E491";
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].scorepopup = "_encstr_B62F20F14D3A5B3298314F941F8348B390D9F6D2851AB94343B8B62209202D5BD55B";
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].playfxcallback = ::helperdronefx;
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].fxid_light1 = [];
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].fxid_light1["_encstr_88BF06FD784A6393"] = loadfx("_encstr_95A4327B90AA879A6F8EE70D7939169BD068ABE7980305625F267D53D4F1E9547848336329797D7BBFB0F6CB48CDA1E22090B397");
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].fxid_light1["_encstr_ACFC091AE8AB2FCBE15119"] = loadfx("_encstr_B45B2316ADA0ADDFDB1B4A768D233FB41877B5812520C9BB7170923A4E8C13AC38ED341C63");
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].primarymodefunc = ::setguardmode;
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].premoddamagefunc = undefined;
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].postmoddamagefunc = ::helperdrone_modifydamagestates;
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].deathfunc = ::helperdronedestroyed;
  level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].damagemonitorfunc = ::helperdrone_watchdamage;

  if(level.gametype == "_encstr_B607038AAB")
    level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].deployweaponname = "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039";
  else
    level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].deployweaponname = "_encstr_B42011379B76D2F27318ABE7680BCA981E68D3";

  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"] = spawnStruct();
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].timeout = undefined;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].maxhealth = 100;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].hitstokill = 3;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].speed = 60;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].accel = 20;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].halfsize = 30;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].spawndist = 100;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].streakname = "_encstr_BEA30A38875DC0976282A037";
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].vehicleinfo = "_encstr_B4521C4B79908F8A75191F6B63A603D7582385D591D16A525E077BD74B4F";
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].modelbase = "_encstr_BA2E179D2B1AC1EBB62D8DAF0BB49C7D6B2C8D99C2AF98D2EC";
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].teamsplash = "_encstr_82F017A377F30A076366E961D8B63F5E5A30629830F7EA3F15";
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].destroyedsplash = "_encstr_8CEE281FB9CDB0781F835639FA6FAD18A509AB991FB2103577FB2E21B3C76868F1670503DA5B68059772";
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].fxid_explode = loadfx("_encstr_8A7A3054A580A84810DA114F33FD5A8493102BC3F3F7F14ACEC005A0F6A913887E19474B8810EB350F2C191DBB135D831868");
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].sound_explode = "_encstr_8C69148BD2530F2861D44D7FF6D779C58B5BC0D06A8F";
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].vodestroyed = "_encstr_83581AC48563C6EB8C27BDB959BE1385D8B5EA83D746596E479CDBF2";
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].votimedout = "_encstr_A3201A6E497532692C0BD75D7AA602F34FEC036FF70B9BFD1DA783D3";
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].scorepopup = "_encstr_AAC71C1956B9E8277B5E5923D7C916C85839D791C9F6B9567DE4ACC6F637";
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].playfxcallback = ::helperdronefx;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].standupoffset = 120;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].crouchupoffset = 80;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].proneupoffset = 46;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].backoffset = 124;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].sideoffset = 55;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].primarymodefunc = ::setdeliverymodesettings;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].premoddamagefunc = undefined;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].postmoddamagefunc = ::helperdrone_modifydamageresponse;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].deathfunc = ::helperdronedestroyed;
  level.helperdronesettings["_encstr_BEA30A38875DC0976282A037"].deployweaponname = "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039";
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"] = spawnStruct();
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].timeout = 45.0;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].maxhealth = 100;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].hitstokill = 3;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].speed = 100;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].accel = 20;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].halfsize = 27;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].spawndist = 30;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].streakname = "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B";
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].vehicleinfo = "_encstr_AF2715886A24FF698723E7E504A396410A52C0E821BD19";
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].modelbase = "_encstr_87D619B3CA8683F55B5A8DFA85B4E4EBE8EAE65A33DB9C5BF51B43";
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].teamsplash = "_encstr_8F34133552DA416EE1B7E860B734C3FF72BAA030AF";
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].destroyedsplash = "_encstr_8ED320BE4F80EB9863CB1EEAFD7FCBB815AB72EF3FBF7B37B88D095B0742123FD63D";
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].fxid_explode = loadfx("_encstr_911C41463253F52C53723F431BEAB0F8B35F333B87C3590A04BF4B702B259AD66B87186B79092B20774E5CD2C6D3A3FD2B05E22E8A480E31210955E3DD7B8F35C87603");
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].sound_explode = "_encstr_A90A146AD31BC59B88A113CA88FD273FB061FCCF79E8";
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].vodestroyed = "_encstr_83581AC48563C6EB8C27BDB959BE1385D8B5EA83D746596E479CDBF2";
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].votimedout = "_encstr_A3201A6E497532692C0BD75D7AA602F34FEC036FF70B9BFD1DA783D3";
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].scorepopup = "_encstr_826D188C558B334207189A8241737A57A1C51C14E0B1E3CDDDC0";
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].playfxcallback = ::helperdronefx;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].primarymode = "_encstr_849007B069FD0B5FDC";
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].primarymodestring = &"_encstr_8D7D1DC9B7DC042FC1EAD5CFB469EF4C7113B99146BABD4959C5DF401B2081";
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].primarymodefunc = ::_id_13128;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].premoddamagefunc = undefined;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].postmoddamagefunc = ::helperdrone_modifydamageresponse;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].deathfunc = ::helperdronedestroyed;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].deployweaponname = "_encstr_83911473FFE146EF9E0163FACBE0CBFA085DF5FF6B40";
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"]._id_11B06 = 0;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"]._id_11B07 = 0;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"]._id_11B17 = 73984;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"]._id_11B18 = 73984;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].leaderinteractionthink = 1;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].leaderboarddata = undefined;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].leaderplunderstring = 1;
  level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"]._id_1217E = undefined;
  var_0 = "_encstr_B607038AAB";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB"))
    var_0 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]();

  if(var_0 == "_encstr_B607038AAB" || var_0 == "_encstr_839E0CBFD1801B5DB0D34C932998") {
    level.helperdronesettings["_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC"].diewithowner = 1;
    level.helperdronesettings["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"].diewithowner = 1;
    level.helperdronesettings["_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60"].diewithowner = 1;
    level.helperdronesettings["_encstr_8C950E2F42AB5B3BFC5B7958BB07909B"].diewithowner = 1;
  }

  level._effect["_encstr_8CB411376C2758AD13B1599CFA9BC693B2B2CD"] = loadfx("_encstr_AA6429CE66E1794BDD0EBEB51CCBD64B638D9B3A93CA85B5979DCC1EEBC8E4B737ACFA9BB1AF16E29DCC1E");
  level._effect["_encstr_ABDF13C7AF039740522D910B992B78562A1F45177E"] = loadfx("_encstr_A69529E48603E53B337701680BDDF72D8B24EE5D0A1FB1670DBBC0C8D127BD982BD56056734F732503A228");
  level._effect["_encstr_93DF13E28EA552250130CFAB911BE3AB53152D11CE"] = loadfx("_encstr_B1A429B3330FF2B4DD0ED7DA8379B5A5B136371D2759B0B6BCCE331EEB239CDE732BBEDC8DF58C5CD9CCC3");
  level._effect["_encstr_A1DF1307FE029FAFDAB89393E9D366F28537467792"] = loadfx("_encstr_A19A29663C02B65CEF3A013A608714673891EBFC4EC9D7E477A09A6331790AC7908D7F736E5656FDBD1883");
  level._effect["_encstr_8FDF13C3E815B65FA9E9BDA268D33F3A53A09A99FA"] = loadfx("_encstr_97C8297B2FC0C20BB32A6F03231E42487C0543B3D20578326E6B05118752163006DF4EAB3E578A58130331");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_88C5055208731B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_88C5055208731B")]]();

  level.incominghelperdrones = [];
  init_helper_drone_vo();
  init_helper_drone_anim();
  level.cargo_truck_horn = getdvarfloat("_encstr_BD8624CDD8E4EB16B99BB0AB8D1DBEC839B79B2B7D59CD2BDA97EB9B7BD1B4CCCB7D3296CDA3", 3000.0);
  level.cargo_truck = getdvarint("_encstr_A6411F53E632B9F77B9F9B8BDB33D0A8EA7D7869018E68BD72D39BD713CA867897", 0);
  level.mine_caves_turrets = getdvarint("_encstr_B2421EA3F9AEE7873077DEDD7FF84A775DB25AE94384F77B6041F7A413E053B7", 1);
}

init_helper_drone_vo() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_BEC918A3B694F8CE0993EDCFA3728018290D4999DFC7E80BA24B"] = "_encstr_B83517F0F9A19AAB3067FA6A96E9518BF091DDC3717124E714";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_972017AA71DB3B1B87F96345D513CE7F29C948343857F80F70"] = "_encstr_8F3517B6D6CA4BCBDFEBE010DB3DA691627E213DEC110B11CC";
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_9AD019321F79A2CA56E0036FA849AFBACBA17EEFF5E7AAE979E813"] = "_encstr_862B18C2EFA9721A8650B33FF839FF2A7377CDFBC3B79A59A918";
}

#using_animtree("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0");
#using_animtree("_encstr_B40101");

init_helper_drone_anim() {
  level.scr_animtree["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"] = #animtree;
  level.scr_anim["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"]["_encstr_BA580B39BD1DED93EBDCC196E6"] = [%_encstr_91EC17AD83F51BABCDA5CC7BE4D6AF27B73ADBC9EB9B38D2B9];
  level.scr_animname["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"]["_encstr_BA580B39BD1DED93EBDCC196E6"] = "_encstr_91EC17AD83F51BABCDA5CC7BE4D6AF27B73ADBC9EB9B38D2B9";
}

weapongivenhelperdrone(var_0) {
  var_1 = var_0.streakname;

  if(var_1 == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD" || var_1 == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC" || var_1 == "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B") {
    var_2 = tryusehelperdroneearlyout(var_0, 1);

    if(var_2) {
      if(var_1 == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD") {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_9B53257BA3512577150F184034CECE2D8129F7FE6D91BF3B35A4D1A91D28FF55418B721FCB8933");
      }

      return 0;
    }

    if(var_1 == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_933717DC8E0B93A39AB007A9561B596C8EA62BB8BAAC733656")]](0, 0, undefined, 1);
    }
  }

  return 1;
}

addincominghelperdrone(var_0) {
  level.incominghelperdrones[level.incominghelperdrones.size] = spawnStruct();
  level.incominghelperdrones[level.incominghelperdrones.size - 1].type = var_0.streakname;
  level.incominghelperdrones[level.incominghelperdrones.size - 1].owner = self;
  level.incominghelperdrones[level.incominghelperdrones.size - 1].team = self.team;
}

removeincominghelperdrone(var_0) {
  if(level.incominghelperdrones.size == 0) {
    return;
  }
  var_1 = [];

  foreach(var_3 in level.incominghelperdrones) {
    if(var_3.type == var_0.streakname && var_3.owner == self) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  level.incominghelperdrones = var_1;
}

addincominghelperdroneifpossible(var_0, var_1) {
  addincominghelperdrone(var_0);

  if(exceededmaxhelperdrones(var_0, self)) {
    removeincominghelperdrone(var_0);
    return 0;
  }

  return 1;
}

incrementfauxvehiclecountifpossible(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BE381A6CAB27392BCD1DA036A396CEACAC2B0DA5B11B5968F657CDD1") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")) {
    if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BE381A6CAB27392BCD1DA036A396CEACAC2B0DA5B11B5968F657CDD1")]]() >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")]]() || level.fauxvehiclecount + 1 >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")]]()) {
      if(istrue(var_1)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_8E8B1E17AB11F063896F4F466499D7A9784FBF8723A8E937E195345C9DB98591");
      }

      return 0;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_A35F1AE79D8E1B5D5881BD03DD0B7573CC136B1F6FA1D23320EBB50B")]](1);

  return 1;
}

recondrone_equipment_wrapper(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8E180EA47FA05F97231022ABC8531553"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8E180EA47FA05F97231022ABC8531553")]](var_1);

  var_3 = tryusehelperdrone("_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC");

  if(!var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D400E8C645BF39D41FF6898A76D3019"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D400E8C645BF39D41FF6898A76D3019")]]("_encstr_871B112B8BD59638EB93ACD8F67332E4DBDC2B", var_1);
  }
}

scramblerdrone_equipment_wrapper(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8E180EA47FA05F97231022ABC8531553"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8E180EA47FA05F97231022ABC8531553")]](var_1);

  var_3 = tryusehelperdrone("_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD");

  if(!var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D400E8C645BF39D41FF6898A76D3019"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D400E8C645BF39D41FF6898A76D3019")]]("_encstr_BDC515ACB85DD207FA37B14E0B6B4CB159E48C4E7BB92B", var_1);
  }
}

radardrone_equipment_wrapper(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8E180EA47FA05F97231022ABC8531553"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8E180EA47FA05F97231022ABC8531553")]](var_1);

  var_3 = tryusehelperdrone("_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60");

  if(!var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D400E8C645BF39D41FF6898A76D3019"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D400E8C645BF39D41FF6898A76D3019")]]("_encstr_A30511636FFB1B30E722E9418E92C8CEF2ABEB", var_1);
  }
}

tryusehelperdrone(var_0) {
  var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo(var_0, self);
  return tryusehelperdronefromstruct(var_1);
}

tryusehelperdronefromstruct(var_0) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](var_0))
      return 0;
  }

  var_1 = 0;

  if(var_0.streakname == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD")
    var_1 = 1;

  if(!var_1) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle())
      return 0;
  }

  var_2 = level.helperdronesettings[var_0.streakname].deployweaponname;
  var_3 = getcompleteweaponname(var_2);

  if(var_2 == "_encstr_B42011379B76D2F27318ABE7680BCA981E68D3")
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, var_3, 1, ::weapongivenhelperdrone);
  else if(var_2 == "_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E")
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, var_3, 1, ::weapongivenhelperdrone);
  else if(var_2 == "_encstr_83911473FFE146EF9E0163FACBE0CBFA085DF5FF6B40")
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweaponswitchdeploy(var_0, var_3, 1, ::weapongivenhelperdrone);
  else if(var_2 == "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039")
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy(var_0, var_3);
  else if(var_2 == "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0")
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(var_0);
  else
    var_4 = 0;

  var_5 = self.start_player_links;
  self.start_player_links = undefined;

  if(!istrue(var_4)) {
    if(!var_1)
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

    if(istrue(var_5)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

      removeincominghelperdrone(var_0);
    }

    return 0;
  }

  if(scripts\cp_mp\utility\player_utility::isinvehicle(1) && self hasweapon(var_3)) {
    if(!var_1)
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

    if(istrue(var_5)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

      removeincominghelperdrone(var_0);
    }

    if(var_2 != "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039")
      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

    return 0;
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](var_0)) {
      if(!var_1)
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

        removeincominghelperdrone(var_0);
      }

      if(var_2 != "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039")
        var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

      return 0;
    }
  }

  var_6 = var_0.streakname;
  var_7 = var_6 == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD" || var_6 == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC" || var_6 == "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B";

  if(!var_7 || var_2 == "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039") {
    var_8 = tryusehelperdroneearlyout(var_0, 1);

    if(var_8) {
      if(!var_1)
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

        removeincominghelperdrone(var_0);
      }

      if(var_2 != "_encstr_93B116F067F7496BAB8B35BE2781A7F13ED7A0689F5F4039")
        var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

      return 0;
    }
  }

  var_9 = find_safe_spawn(var_6);

  if(var_2 == "_encstr_979914D35F4122577120938A0EDD6F9B58E7551F8BE0") {
    if(!isDefined(var_9)) {
      if(!var_1)
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

        removeincominghelperdrone(var_0);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_BE361D694AC4269A8A94A2145A35E5C99EA2EB1527D355E884F56A41281A51");

      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      return 0;
    }
  }

  if(var_2 == "_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E" || var_2 == "_encstr_83911473FFE146EF9E0163FACBE0CBFA085DF5FF6B40") {
    if(istrue(level.mine_caves_turrets))
      self freezecontrols(1);
    else
      scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "_encstr_A2841CA1CAC6835939884EDBDC59D2B4D88DB9A34E56C2AD11590E36DBCB");

    var_10 = 0.6;
    var_11 = 2;
    var_12 = scripts\engine\utility::_id_143BA(var_10, "_encstr_AD75063D571AE108", "_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC");

    if(!isDefined(var_12) || var_12 != "_encstr_995408F398012F656821") {
      if(!var_1)
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

        removeincominghelperdrone(var_0);
      }

      if(istrue(level.mine_caves_turrets))
        self freezecontrols(0);
      else
        scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "_encstr_A2841CA1CAC6835939884EDBDC59D2B4D88DB9A34E56C2AD11590E36DBCB");

      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      return 0;
    }

    scripts\common\utility::allow_weapon_switch(0);
    var_12 = scripts\engine\utility::_id_143B9(var_11 - var_10, "_encstr_AD75063D571AE108");

    if(!isDefined(var_12) || var_12 != "_encstr_995408F398012F656821") {
      if(!var_1)
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

        removeincominghelperdrone(var_0);
      }

      if(istrue(level.mine_caves_turrets))
        self freezecontrols(0);
      else
        scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "_encstr_A2841CA1CAC6835939884EDBDC59D2B4D88DB9A34E56C2AD11590E36DBCB");

      scripts\common\utility::allow_weapon_switch(1);
      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
      return 0;
    }

    if(istrue(level.mine_caves_turrets))
      self freezecontrols(0);
    else
      scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "_encstr_A2841CA1CAC6835939884EDBDC59D2B4D88DB9A34E56C2AD11590E36DBCB");

    scripts\common\utility::allow_weapon_switch(1);
  }

  var_13 = undefined;

  if(var_2 == "_encstr_B42011379B76D2F27318ABE7680BCA981E68D3") {
    var_13 = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB"))
      var_13 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_B86B122720C9FFAA9C813F4CB0CF03D14F83D0DB")]](var_0, 1);

    if(!isDefined(var_13)) {
      if(!var_1)
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

        removeincominghelperdrone(var_0);
      }

      return 0;
    }
  } else if(var_6 == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD") {
    var_14 = self.origin;

    if(isDefined(level._id_13C34)) {
      var_15 = [[level._id_13C34]](self.origin);
      var_14 = var_15["_encstr_BD260953AA97E3F014279D"];
    }

    var_16 = spawnStruct();
    var_16.location = var_14;
    var_13 = [];
    var_13[0] = var_16;
  }

  var_17 = self.angles;
  var_18 = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_83011BC11B0B5E2D5AD8B1373A395916B688CA83B17BE5444B16D8F6D9")]](self, var_0.streakname);
    var_18 = 2.0;
  }

  if(level.gametype == "_encstr_B607038AAB") {
    if(var_6 == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD")
      scripts\cp_mp\killstreaks\uav::_id_13ED5(self.team, 15000, "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD");
  }

  if(isDefined(var_13)) {
    if(var_6 == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD") {
      var_19 = var_13[0].location + (0, 0, 3000);
      var_20 = createhelperdrone(var_19, var_17, var_6, var_0, var_1, !var_1);

      if(!isDefined(var_20)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_88DC1899E78C341FF13A053F44B9DFDF265FF9310F542D751897");

        if(istrue(var_5)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
            [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

          removeincominghelperdrone(var_0);
        }

        return 0;
      }

      var_20.mappointinfo = var_13;
      var_20 thread perkengineer_manageminimap();
      removeincominghelperdrone(var_0);
      thread starthelperdrone(var_20);
    }
  } else {
    if(var_6 == "_encstr_81E01312A3403EA3C0F95B724025DFF7200FB79A11" || var_6 == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC" || var_6 == "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B")
      var_9 = find_safe_spawn(var_6);

    if(var_6 == "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60")
      var_9 = self.origin + (0, 0, 1500) - anglesToForward(self.angles) * 5000;

    var_20 = createhelperdrone(var_9, var_17, var_6, var_0, var_1, !var_1);

    if(!isDefined(var_20)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_BE361D694AC4269A8A94A2145A35E5C99EA2EB1527D355E884F56A41281A51");

      helperdronecreationfailedfx(var_6, var_9);
      var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");

      if(istrue(var_5)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

        removeincominghelperdrone(var_0);
      }

      return 0;
    }

    if(var_6 == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC" || var_6 == "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B")
      thread helperdrone_giveplayerfauxremote(var_0);

    removeincominghelperdrone(var_0);
    thread starthelperdrone(var_20);
  }

  thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog("_encstr_A7E40528F8D8C7" + var_0.streakname, 1, var_18);
  var_21 = level.helperdronesettings[var_6].teamsplash;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B675156D3DDFF0C17D7AB850A35E5BEB2393F7E991CF18")]](var_21, self);

  return 1;
}

helperdronecreationfailedfx(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = self getEye() + (0, 0, 80);

  var_2 = level.helperdronesettings[var_0];
  var_3 = "_encstr_831904EFF7F7" + var_0 + "_encstr_851A049F8337";

  if(var_0 == "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B")
    var_3 = var_2.modelbase;

  var_4 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_4 setModel(var_3);
  var_4 setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_AB0703DBB9", 0);
  var_4 thread delay_deletescriptable("_encstr_860808CB78E2984063BA");
}

tryusehelperdroneearlyout(var_0, var_1) {
  if(scripts\cp_mp\utility\player_utility::isusingremote())
    return 1;

  if(istrue(self.drones_disabled)) {
    if(var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_88DC1899E78C341FF13A053F44B9DFDF265FF9310F542D751897");
    }

    return 1;
  }

  if((var_0.streakname == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC" || var_0.streakname == "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B") && (!self isonground() && !self isonladder() || _calloutmarkerping_handleluinotify_enemyrepinged::updateleaders())) {
    if(var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_97911CFB309569F34788CDD6616BBC8156BC63678BE6D1A84721A69F2917");
    }

    return 1;
  }

  if(isDefined(level.getfirespoutlaunchvectors)) {
    if(![[level.getfirespoutlaunchvectors]](self)) {
      if(var_1) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_97911CFB309569F34788CDD6616BBC8156BC63678BE6D1A84721A69F2917");
      }

      return 1;
    }
  }

  var_2 = incrementfauxvehiclecountifpossible(var_0, var_1);

  if(!var_2)
    return 1;

  var_3 = addincominghelperdroneifpossible(var_0, var_1);

  if(!var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]](1);

    return 1;
  }

  self.start_player_links = 1;
  return 0;
}

delay_deletescriptable(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(2);
  self delete();
}

createhelperdrone(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = !istrue(var_4) && istrue(var_5);

  if(!isDefined(var_0)) {
    if(!istrue(var_6))
      scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  } else {
    var_7 = level.helperdronesettings[var_2];
    var_8 = var_7.modelbase;

    if(scripts\cp_mp\utility\player_utility::getplayersuperfaction(self) && isDefined(var_7.modelbasealt))
      var_8 = var_7.modelbasealt;

    var_9 = undefined;

    if(istrue(var_4)) {
      var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0);
      var_9 setModel(var_8);
      var_9.nonvehicle = 1;
    } else {
      if(var_6)
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

      var_9 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(self, var_0, var_1, var_7.vehicleinfo, var_8);
    }

    if(!isDefined(var_9)) {
      return;
    }
    var_9 enableaimassist();
    var_9 setnodeploy(1);
    var_9.health = var_7.maxhealth;
    var_9.maxhealth = var_7.maxhealth;
    var_9.damagetaken = 0;
    var_9.speed = var_7.speed;
    var_9.accel = var_7.accel;
    var_9.angles = var_1;
    var_9.manualspeed = 50;
    var_9.owner = self;
    var_9.team = self.team;
    var_9.helperdronetype = var_2;
    var_9.combatmode = var_7.primarymode;
    var_9.currentstring = var_7.secondarymodestring;
    var_9.streakinfo = var_3;
    var_9.currentdamagestate = 0;

    if(istrue(var_9.nonvehicle))
      var_9 scripts\mp\sentientpoolmanager::registersentient("_encstr_879610D1FF4A45C8EBD61876F5DF0873327F", self, undefined, undefined, 0, 1);
    else {
      var_9 scripts\mp\sentientpoolmanager::registersentient("_encstr_8E830EA9A77303302C91E4B8C30173CC", self);
      var_9 setvehicleteam(var_9.team);
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B"))
      var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A76B16AD2D1B366EE8279558AD6A586D2B65B24396368D2B")]](var_7.streakname, var_7.scorepopup, var_7.vodestroyed, undefined, var_7.destroyedsplash);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD"))
      var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_BA2C22DA4B1B636E3A4EACB05BA959D1824EAC35DE3211C2ADC2ECB2A1161BD83116D8AD")]](var_3.streakname, var_7.premoddamagefunc);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8"))
      var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B8E23648C086413B108EF30B3A2C961BF8722F3617FE2ECDF5B3AC730C7790D109589A9B8")]](var_3.streakname, var_7.postmoddamagefunc);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF"))
      var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C31B72E8F17B12703D858927615FC33D812A0B50CE078DC805B993DF")]](var_3.streakname, var_7.deathfunc);

    if(isDefined(var_7.flarescount))
      var_9.flaresreservecount = var_7.flarescount;

    var_9 setotherent(self);
    var_9 setCanDamage(1);

    if(istrue(var_4)) {
      var_9 scriptmoveroutline();
      var_9 scriptmoverthermal();
    } else {
      var_9 vehicle_invoketriggers(1);
      var_9 vehicle_breakglass(1);
    }

    var_11 = 12;

    switch (var_2) {
      case "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60":
        var_11 = 60;
        break;
      case "_encstr_8FBC173B6136974D08F94D428760D2E750D971C2CB06774250":
        var_12 = var_9 helperdrone_spawnnewscrambler("_encstr_AB5E07609A5B7368E5");
        var_9.scrambler = var_12;
        break;
      case "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD":
        if(istrue(level._id_11A9D)) {
          var_12 = var_9 helperdrone_spawnnewscrambler("_encstr_8DEC06B1E943615B");
          var_9.scrambler = var_12;
        }

        var_11 = 100;
        break;
      case "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC":
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB") {
            var_9 vehicleshowonminimap(0);

            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_8AD1186F4D42A32421F358A8FB52B9CB4ABB667DAF3A5B081FC7"))
              [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_8AD1186F4D42A32421F358A8FB52B9CB4ABB667DAF3A5B081FC7")]]("_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC");

            var_9 spawn_additional_covernode(var_2);
          }
        }

        break;
      case "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B":
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
          if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB") {
            var_9 vehicleshowonminimap(0);

            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_8AD1186F4D42A32421F358A8FB52B9CB4ABB667DAF3A5B081FC7"))
              [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_8AD1186F4D42A32421F358A8FB52B9CB4ABB667DAF3A5B081FC7")]]("_encstr_8C950E2F42AB5B3BFC5B7958BB07909B");

            var_9 spawn_additional_covernode(var_2);
          }
        }

        break;
      default:
        break;
    }

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23"))
      var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_921B1AD3D478AF17A073A49C55D25C7018C9524B4648513A43281F23")]](var_3.streakname, "_encstr_81860F1741A58ADBBB43D3B36C79AF3083", var_9.owner, 0, 1, var_11);

    var_9.attract_strength = 10000;
    var_9.attract_range = 150;
    var_9.attractor = missile_createattractorent(var_9, var_9.attract_strength, var_9.attract_range);
    var_9.stunned = 0;
    var_9.inactive = 0;
    var_9 thread helperdrone_play_lightfx();
    var_13 = spawnStruct();
    var_13.validateaccuratetouching = 1;
    var_13.deathoverridecallback = ::helperdrone_moving_platform_death;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_848616BBDB20527C20A8256BC090BFCB8973730B5F568A3B"))
      var_9[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_848616BBDB20527C20A8256BC090BFCB8973730B5F568A3B")]](var_13);

    if(isDefined(level.helperdronesettings[var_9.helperdronetype].streakname)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084"))
        var_9.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_870A137C78DAD34CC8844325CE9D76B38743E05084")]](var_7.streakname, var_9.targetpos);
    }
  }
}

spawn_additional_covernode(var_0) {
  var_1 = 3000;

  if(var_0 == "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B")
    var_1 = level.cargo_truck_horn;

  var_2 = level.teamdata[self.team]["_encstr_9775086022BE1B413B8B"];
  var_3 = scripts\common\utility::playersincylinder(self.origin, var_1, var_2);

  foreach(var_5 in var_3) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8E65136B88A3B4EDC330C74B3236E3C191E981E522"))
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8E65136B88A3B4EDC330C74B3236E3C191E981E522")]](var_5, var_0, 1);
  }
}

helperdrone_handleteamvisibility() {
  foreach(var_1 in level.players) {
    if(level.teambased && var_1.team == self.team || !level.teambased && var_1 == self.owner)
      self hidefromplayer(var_1);
  }

  thread helperdrone_managevisibilityonteamjoin();
}

helperdrone_managevisibilityonteamjoin() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");

  for(;;) {
    level waittill("_encstr_81170C244F9CBDE72C01BB99A298", var_0);

    if(level.teambased && var_0.team == self.team) {
      self hidefromplayer(var_0);
      continue;
    }

    self showtoplayer(var_0);
  }
}

helperdrone_endscramblereffect() {
  self notify("_encstr_BEBD1803B60278C15A33432F57F39790BA0129D89D71B00B02FB");

  if(isDefined(self.new_objective_thread) && self.new_objective_thread.size > 0) {
    foreach(var_1 in self.new_objective_thread) {
      if(isDefined(var_1)) {
        var_2 = var_1;

        if(isDefined(var_2.owner))
          var_2 = var_2.owner;

        var_2 notify("_encstr_9AEB0D0BBFE82637B68DC269489C23");
      }
    }
  }

  if(isDefined(self.friendliesaffectedbyscrambler) && self.friendliesaffectedbyscrambler.size > 0) {
    foreach(var_5 in self.friendliesaffectedbyscrambler) {
      if(isDefined(var_5))
        var_5 notify("_encstr_9AEB0D0BBFE82637B68DC269489C23");
    }
  }
}

spawn_ai_single(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_BEBD1803B60278C15A33432F57F39790BA0129D89D71B00B02FB");

  if(!isDefined(var_0))
    var_0 = self.owner;

  self.new_objective_thread = [];
  var_1 = 0;
  var_2 = getdvarfloat("_encstr_876917B1BDB61CB09BCD9AD8E4B0DAC48D5993A4C246A5BAB9", 1000);
  var_3 = var_2 * var_2;
  var_4 = physics_createcontents(["_encstr_925717EBF99B13491B7BD6DD30508D3AF527CF6349CFFB3DD0"]);
  var_5 = self.origin - (0, 0, 3000);
  var_6 = (var_2, var_2, 3000);
  var_7 = var_5 - var_6;
  var_8 = var_5 + var_6;

  for(;;) {
    var_9 = physics_aabbbroadphasequery(var_7, var_8, var_4, []);

    foreach(var_11 in var_9) {
      var_12 = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA"))
        var_12 = var_11[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_8BA31B339B413F3148C5C45A3F677FADBFF3425B7D5DAFF3CDA31A1F63");

      if(isDefined(var_11) && var_11 scripts\cp_mp\utility\player_utility::_isalive() && !var_12) {
        if(distance2dsquared(self.origin, var_11.origin) > var_3) {
          continue;
        }
        if(var_1 || level.teambased && var_11.team != self.team && var_11.team != "_encstr_AF8C0A1B6A1D6045925B4F7D" || !level.teambased && var_11 != self.owner) {
          if(var_11 scripts\cp_mp\utility\player_utility::isusingremote()) {
            continue;
          }
          if(var_11 helperdrone_entaffectedbyscramble(self, var_1)) {
            continue;
          }
          var_11 helperdrone_setscramblerjammed(1, self, var_1);
        }

        continue;
      }

      if(isDefined(var_11.scrambledby) && var_11.scrambledby == self)
        var_11 notify("_encstr_9AEB0D0BBFE82637B68DC269489C23");
    }

    waitframe();
  }
}

helperdrone_setscramblerplayerbuffs(var_0, var_1) {
  if(helperdrone_entaffectedbyscramble(var_1) && istrue(var_0)) {
    return;
  }
  if(istrue(var_0)) {
    var_1.friendliesaffectedbyscrambler[var_1.friendliesaffectedbyscrambler.size] = self;
    thread helperdrone_managescramblerplayerbuff(var_1);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5")]]("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_AB1109D9B4EC2B05954EB5")]]("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
  } else if(isDefined(self)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD")]]("_encstr_9A86139BA008488198DBDB8B56EE5901CD4B57F0A7");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD")]]("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9");
  }
}

helperdrone_managescramblerplayerbuff(var_0) {
  scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_9AEB0D0BBFE82637B68DC269489C23");
  helperdrone_setscramblerplayerbuffs(0, var_0);
}

helperdrone_setscramblerjammed(var_0, var_1, var_2) {
  var_3 = self;

  if(istrue(var_0)) {
    var_3.scrambledby = var_1;

    if(!scripts\engine\utility::array_contains(var_1.new_objective_thread, var_3))
      var_1.new_objective_thread[var_1.new_objective_thread.size] = var_3;

    var_3 thread helperdrone_managescramblereffect(var_1, var_2);
    var_3 thread helperdrone_watchscramblestrength(var_1);
  } else if(isDefined(var_3)) {
    var_3.scrambledby = undefined;
    var_3 scripts\cp_mp\emp_debuff::stop_emp_scramble(var_3.currentscramblerstrength);
    var_3.previousscramblerstrength = undefined;
    var_3.currentscramblerstrength = undefined;
  }
}

helperdrone_managescramblereffect(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143A5("_encstr_AD75063D571AE108", "_encstr_9AEB0D0BBFE82637B68DC269489C23");

  if(isDefined(self)) {
    helperdrone_setscramblerjammed(0, var_0, var_1);

    if(isDefined(var_0) && isDefined(var_0.new_objective_thread))
      var_0.new_objective_thread = scripts\engine\utility::array_remove(var_0.new_objective_thread, self);
  } else if(isDefined(var_0) && isDefined(var_0.new_objective_thread))
    var_0.new_objective_thread = scripts\engine\utility::array_removeundefined(var_0.new_objective_thread);
}

helperdrone_watchremotescrambledent(var_0, var_1) {
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self waittill("_encstr_AD75063D571AE108");

  if(isDefined(self.owner)) {
    if(self.owner helperdrone_entaffectedbyscramble(var_0, var_1))
      self.owner helperdrone_setscramblerjammed(0, var_0, var_1);
  }
}

helperdrone_watchscramblestrength(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9AEB0D0BBFE82637B68DC269489C23");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_1 = 0;
  var_2 = 0;
  var_3 = getdvarfloat("_encstr_876917B1BDB61CB09BCD9AD8E4B0DAC48D5993A4C246A5BAB9", 1000);
  var_4 = var_3 * var_3;

  for(;;) {
    var_5 = distance2dsquared(var_0.origin, self.origin);

    if(var_5 > var_4)
      var_2 = 0;
    else if(var_5 >= var_4 * 0.8)
      var_2 = 1;
    else if(var_5 >= var_4 * 0.6)
      var_2 = 2;
    else if(var_5 >= var_4 * 0.4)
      var_2 = 3;
    else if(var_5 >= var_4 * 0.2)
      var_2 = 4;
    else
      var_2 = 5;

    var_6 = var_2 != var_1;

    if(var_1 == 0 || var_6) {
      self.previousscramblerstrength = var_1;
      self.currentscramblerstrength = var_2;

      if(self.previousscramblerstrength > 1)
        var_7 = self.previousscramblerstrength;

      if(self.currentscramblerstrength > 1)
        var_7 = self.currentscramblerstrength;

      scripts\cp_mp\emp_debuff::stop_emp_scramble(var_1);
      scripts\cp_mp\emp_debuff::play_emp_scramble(var_2);
      var_1 = var_2;
    }

    waitframe();
  }
}

helperdrone_entaffectedbyscramble(var_0, var_1) {
  var_2 = 0;
  var_3 = undefined;

  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(var_5 in level.supportdrones) {
      if(var_5.helperdronetype != "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD") {
        continue;
      }
      if(level.teambased) {
        if(!isDefined(var_1) && var_5.team == self.team)
          var_3 = var_5.friendliesaffectedbyscrambler;
        else
          var_3 = var_5.new_objective_thread;
      } else if(!isDefined(var_1) && var_5.owner == self)
        var_3 = var_5.friendliesaffectedbyscrambler;
      else
        var_3 = var_5.new_objective_thread;

      if(!isDefined(var_3)) {
        continue;
      }
      if(var_3.size > 0) {
        foreach(var_7 in var_3) {
          if(self == var_7 || isDefined(var_7.owner) && self == var_7.owner) {
            var_2 = 1;
            break;
          }
        }

        if(istrue(var_2)) {
          break;
        }
      }
    }
  }

  return var_2;
}

helperdrone_enableradar(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_1.owner = self.owner;
  var_1.team = self.owner.team;
  self.radar = var_1;

  if(var_0 == "_encstr_A1570B58EA1DDBD7930B192C4E")
    var_1 makeportableradar(self.owner);
  else if(var_0 == "_encstr_95570D3DE31F787D835138B8FA9E35") {
    var_1 setentityowner(self.owner);
    var_1 setotherent(self.owner);
    var_1 setModel("_encstr_8205197F13C985FF6102265891E2885D7D8F7FABB7AA2A83F7F180");
  } else if(var_0 == "_encstr_A3970CFDCF86B5E8395A4889F81B") {
    var_1 setentityowner(self.owner);
    var_1 setotherent(self.owner);
    var_1 setModel("_encstr_96CB18AFFFA02AD37126E249179A5D5AC319C2B0037F15A93381");
    var_2 = 1.5;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
      if(self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_92CB1FCD0EB21BA5B063D12FAFD2D63827B73B5923FAE85839ECCAE8EB5B1627D6"))
        var_2 = var_2 * getdvarfloat("_encstr_86F81FC19527DAFAD10B939DB21DBE6B16275BCAC87D1BBD73B32BC9F5E40B1DAC");
    }

    thread helperdrone_watchradartrigger(500, 10, 0.1, var_2);
  }

  var_1 linkTo(self);
}

helperdrone_watchradartrigger(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  self.trigger = spawn("_encstr_BE66191DB6995910437226C04038E353EE95B49957DAAE91C3AD72", self.origin, 0, var_0, var_0);

  for(;;) {
    self.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_4);

    if(!isPlayer(var_4)) {
      continue;
    }
    if(level.teambased) {
      if(var_4.team == self.team)
        continue;
    }

    if(var_4 == self.owner) {
      continue;
    }
    for(var_5 = 0; var_5 < 3; var_5++) {
      var_6 = var_0 / var_1 * 0.05 * 1000;

      if(level.teambased)
        triggerportableradarpingteam(self.radar.origin, self.radar.team, var_0, int(var_6 / 2));
      else
        triggerportableradarping(self.radar.origin, self.radar.owner, var_0, int(var_6 / 2));

      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
      self.radar setscriptablepartstate("_encstr_8A0C06B1E08832D3", "_encstr_AB0703DBB9", 0);
      self playSound("_encstr_B6CA17DE4EC2B1B1CAF59316C82CC97D1CAB36E659F5CD3836");
      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_6 / 1000);
      self.radar setscriptablepartstate("_encstr_8A0C06B1E08832D3", "_encstr_BA19049F4B2D", 0);
    }

    self notify("_encstr_AD75063D571AE108");
  }
}

helperdrone_disableradar() {
  if(isDefined(self.radar))
    self.radar delete();
}

helperdrone_spawnnewscrambler(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", self.origin);
  var_3.team = self.owner.team;
  var_3 makescrambler(self.owner, var_0);
  var_3 linkTo(self);
  return var_3;
}

helperdrone_moving_platform_death(var_0) {
  if(!isDefined(var_0.lasttouchedplatform.destroydroneoncollision) || var_0.lasttouchedplatform.destroydroneoncollision)
    self notify("_encstr_AD75063D571AE108");
}

helperdrone_play_lightfx() {
  var_0 = level.helperdronesettings[self.helperdronetype];

  if(isDefined(var_0.playfxcallback))
    self[[var_0.playfxcallback]]();
}

helperdronefx() {
  self setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", "_encstr_AB0703DBB9", 0);

  if(self.helperdronetype == "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60") {
    self setscriptablepartstate("_encstr_B4D506B3C62D373A", "_encstr_AB0703DBB9", 0);
    self setscriptablepartstate("_encstr_817F076A48F76C8B81", "_encstr_AB0703DBB9", 0);
  }

  if(self.helperdronetype == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC")
    self setscriptablepartstate("_encstr_B4D506B3C62D373A", "_encstr_AB0703DBB9", 0);

  if(self.helperdronetype == "_encstr_BEA30A38875DC0976282A037")
    self setscriptablepartstate("_encstr_B4D506B3C62D373A", "_encstr_AB0703DBB9", 0);
}

starthelperdrone(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 endon("_encstr_AD75063D571AE108");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

  var_1 = level.helperdronesettings[var_0.helperdronetype];

  if(isDefined(var_1.damagemonitorfunc))
    var_0 thread[[var_1.damagemonitorfunc]]();

  var_0 thread helperdrone_watchtimeout();
  var_0 thread helperdrone_watchownerloss();
  var_0 thread helperdrone_watchownerdeath();
  var_0 thread helperdrone_watchroundend();
  var_0 thread helperdrone_destroyongameend();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")) {
    var_2 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]();

    if(var_2 == "_encstr_B607038AAB")
      var_0 thread spawn_ai_and_seat_in_vehicle(self);
  }

  var_0 setCanDamage(1);
  var_0 thread[[var_1.primarymodefunc]](var_1);
}

helperdrone_followplayer(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_B4320EEBA04D7F371338F1FBC658A743");
  self endon("_encstr_86640E0E8D855E954EFA8C5999ACB98C");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");

  if(!isDefined(self.owner)) {
    thread helperdrone_leave();
    return;
  }

  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8B460B3A23F8474A212F879E33");

  for(;;) {
    var_1 = self.owner getstance();

    if(!isDefined(self.last_owner_stance) || var_1 != self.last_owner_stance || istrue(self.stoppedatlocation)) {
      if(istrue(self.stoppedatlocation))
        self.stoppedatlocation = undefined;

      self.last_owner_stance = var_1;
      helperdrone_movetoplayer(self.owner, var_0);
    }

    wait 0.5;
  }
}

helperdrone_overwatchplayer() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43")]]();

  self.owner.showuavminimaponspawn = 1;
  self.owner thread helperdrone_showminimaponspawn(self);
  var_0 = 1;
  self vehicle_setspeed(200, 50, 10);

  for(;;) {
    var_1 = undefined;

    if(istrue(var_0)) {
      var_2 = self.origin;
      var_3 = self.owner.origin * (1, 1, 0) + (0, 0, self.origin[2]);
      var_1 = scripts\engine\trace::ray_trace(var_2, var_3, self);
    }

    var_4 = self.owner.origin[0];
    var_5 = self.owner.origin[1];

    if(isDefined(var_1)) {
      if(var_1["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
        var_4 = var_1["_encstr_BD260953AA97E3F014279D"][0];
        var_5 = var_1["_encstr_BD260953AA97E3F014279D"][1];
      }
    }

    var_6 = getcorrectheight(var_4, var_5, 20);
    var_7 = (var_4, var_5, var_6);
    self setlookatent(self.owner);
    self setvehgoalpos(var_7, 1);
    scripts\engine\utility::_id_143A5("_encstr_8B7205D9ED5958", "_encstr_8EED1805A567F080CFFA6BB1A32F4458B1358BE54D4BB05D13F3");

    if(istrue(var_0)) {
      var_0 = undefined;
      self vehicle_setspeed(level.helperdronesettings[self.helperdronetype].speed, 10, 10);
    }

    self clearlookatent();
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.1);
  }
}

getcorrectheight(var_0, var_1, var_2) {
  var_3 = 1500;
  var_5 = tracegroundpoint(var_0, var_1);
  var_6 = var_5 + var_3;
  var_6 = var_6 + randomint(var_2);
  return var_6;
}

tracegroundpoint(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  var_2 = -99999;
  var_3 = self.origin[2] + 2000;
  var_4 = level.averagealliesz;
  var_5 = [self];
  var_6 = scripts\engine\trace::sphere_trace((var_0, var_1, var_3), (var_0, var_1, var_2), 256, var_5, undefined, 1);

  if(var_6["_encstr_BD260953AA97E3F014279D"][2] < var_4)
    var_7 = var_4;
  else
    var_7 = var_6["_encstr_BD260953AA97E3F014279D"][2];

  return var_7;
}

helperdrone_pingnearbyenemies() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = 300;
  var_1 = 1200;

  if(scripts\cp_mp\utility\game_utility::islargemap()) {
    var_0 = 1000;
    var_1 = 2500;
  }

  self._id_12368 = [];

  for(;;) {
    var_2 = scripts\common\utility::playersinsphere(self.owner.origin, var_1);

    foreach(var_4 in var_2) {
      if(var_4 == self.owner) {
        continue;
      }
      if(level.teambased && var_4.team == self.owner.team) {
        continue;
      }
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")]](var_4))
          continue;
      }

      if(var_4 source(self)) {
        continue;
      }
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
        if(var_4[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_990810B8796F28FB0B6193B21770B42573B3"))
          continue;
      }

      triggerportableradarping(var_4.origin, self.owner, var_0, 3000);
      thread helperdrone_watchpingedstatus(var_4, self.owner);
    }

    waitframe();
  }
}

helperdrone_watchpingedstatus(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(isDefined(var_1))
    var_0 playsoundtoplayer("_encstr_8C80123BD899971AC93ED58DAD97E221035BFFB3", var_1);

  self._id_12368[self._id_12368.size] = var_0;
  var_0 scripts\engine\utility::_id_143B9(3, "_encstr_AD75063D571AE108");
  self._id_12368 = scripts\engine\utility::array_remove(self._id_12368, var_0);
}

source(var_0) {
  var_1 = 0;

  foreach(var_3 in var_0._id_12368) {
    if(isDefined(var_3) && self == var_3) {
      var_1 = 1;
      break;
    }
  }

  return var_1;
}

helperdrone_getheightoffset(var_0) {
  var_1 = var_0.standupoffset;
  var_2 = self.owner getstance();

  switch (var_2) {
    case "_encstr_A5AD069B231F0BAF":
      var_1 = var_0.standupoffset;
      break;
    case "_encstr_B13D076BED70539F23":
      var_1 = var_0.crouchupoffset;
      break;
    case "_encstr_922406F1A6FD5E05":
      var_1 = var_0.proneupoffset;
      break;
  }

  return var_1;
}

helperdrone_guardlocation() {
  self.stoppedatlocation = 1;
  var_0 = self.origin[2] / 2;
  var_1 = self.mappointinfo[0].location + (0, 0, var_0);
  var_2 = scripts\engine\trace::sphere_trace(self.origin, var_1, 200, self);

  if(isDefined(var_2)) {
    if(isDefined(var_2["_encstr_850E077B0BF30318B9"])) {
      var_1 = var_2["_encstr_850E077B0BF30318B9"].origin + (0, 0, randomintrange(50, 150));

      if(isDefined(var_2["_encstr_850E077B0BF30318B9"].guardlocation))
        var_1 = var_2["_encstr_850E077B0BF30318B9"].guardlocation + (0, 0, randomintrange(50, 150));
    } else if(isDefined(var_2["_encstr_AA1C0886968EA32FE056"]) && isDefined(var_2["_encstr_BD260953AA97E3F014279D"]) && var_2["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A")
      var_1 = var_2["_encstr_BD260953AA97E3F014279D"] + (0, 0, randomintrange(50, 150));
  }

  thread helperdrone_moveintoplace(var_1);
  self.guardlocation = var_1;
}

helperdrone_moveintoplace(var_0) {
  self endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self setscriptablepartstate("_encstr_AFF4077B8D5B65E20B", "_encstr_AB0703DBB9", 0);
  self playLoopSound("_encstr_91BB1E3BCA1A7DB9369CB0B598D8CAE4EB324EBD9B2BBEB446D82BEB344BCE1A");
  self moveTo(var_0 - (0, 0, 20), 3, 2, 1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.2);
  self moveTo(var_0, 1, 0.5, 0.5);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1.2);

  for(;;) {
    var_1 = randomintrange(-35, 35);
    var_2 = randomintrange(-15, 15);
    var_3 = var_0[0] + var_1;
    var_4 = var_0[1] + var_1;
    var_5 = var_0[2] + var_2;
    var_6 = (var_3, var_4, var_5);
    self moveTo(var_6, 3, 2, 1);
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3.2);
  }
}

helperdrone_watchradarpulse() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    triggerportableradarping(self.origin, self.owner);
    self.owner playSound("_encstr_B6CA17DE4EC2B1B1CAF59316C82CC97D1CAB36E659F5CD3836");
    wait 3;
  }
}

helperdrone_movetoplayer(var_0, var_1) {
  self setlookatent(var_0);
  var_2 = helperdrone_gettargetoffset(self, var_0);

  if(isDefined(var_1))
    var_2 = var_1;

  self setdronegoalent(var_0, var_2, 16, 10);
  self.intransit = 1;
  thread helperdrone_watchforgoal();
}

helperdrone_watchmodeswitch() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8B460B3A23F8474A212F879E33");
  var_0 = level.helperdronesettings[self.helperdronetype];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_820E1D2BED4847BA4CC538CC3B68B1A213E2A29CA0378D704E93C25ABA3BF2"))
    self.useobj[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_820E1D2BED4847BA4CC538CC3B68B1A213E2A29CA0378D704E93C25ABA3BF2")]](self.owner, self.currentstring, 360, 360, 30000, 30000, 3);

  for(;;) {
    self.useobj waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

    if(var_1 != self.owner) {
      continue;
    }
    if(self.owner scripts\cp_mp\utility\player_utility::isusingremote()) {
      continue;
    }
    if(!self.owner scripts\common\utility::is_usability_allowed()) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_850E077B0BF30318B9", "_encstr_9267184F4F1D15E3361864D0C49D474580990B65EA01883A4DE2")) {
      if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_850E077B0BF30318B9", "_encstr_9267184F4F1D15E3361864D0C49D474580990B65EA01883A4DE2")]](self.owner))
        continue;
    }

    var_2 = 0;
    var_3 = undefined;
    var_4 = level.framedurationseconds;

    while(self.owner useButtonPressed()) {
      var_2 = var_2 + var_4;

      if(var_2 > 0.1) {
        self notify("_encstr_A69B0D1B03D755707C3F838F2C67A8");
        var_5 = getothermode(self.combatmode, self.streakinfo);
        var_6 = "_encstr_B80D0DC0CF331B980E7B6482772BBF";

        if(var_5 == var_0.primarymode) {
          var_3 = [[var_0.primarymodefunc]](var_0);
          var_6 = var_0.secondarymodestring;
        } else {
          var_3 = [[var_0.secondarymodefunc]](var_0);
          var_6 = var_0.primarymodestring;
        }

        if(!istrue(var_3)) {
          return;
        }
        self.combatmode = var_5;
        self.currentstring = var_6;
        self.useobj makeunusable();
        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(1);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_820E1D2BED4847BA4CC538CC3B68B1A213E2A29CA0378D704E93C25ABA3BF2"))
          self.useobj[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_820E1D2BED4847BA4CC538CC3B68B1A213E2A29CA0378D704E93C25ABA3BF2")]](self.owner, self.currentstring, 360, 360, 30000, 30000, 3);

        break;
      }

      wait(var_4);
    }

    wait(var_4);
  }
}

getothermode(var_0, var_1) {
  var_2 = level.helperdronesettings[self.helperdronetype];

  if(var_0 == var_2.primarymode)
    var_0 = var_2.secondarymode;
  else
    var_0 = var_2.primarymode;

  return var_0;
}

setescortmodesettings(var_0) {
  self vehicle_setspeed(self.speed, self.accel);
  self setyawspeed(120, 90);
  self setneargoalnotifydist(16);
  self sethoverparams(30, 10, 5);
  self setturningability(1);
  self setdroneturnparams(50, 1.3, 30, 20);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43")]]();

  self.owner thread helperdrone_showminimaponspawn(self);
  helperdrone_enableradar("_encstr_95570D3DE31F787D835138B8FA9E35");
  thread helperdrone_followplayer();
  return 1;
}

setreconmodesettings(var_0) {
  self.playersfx = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  self.playersfx showonlytoplayer(self.owner);
  self.playersfx linkTo(self);
  self.playersfx playLoopSound("_encstr_937D14E4AC6CBDB9F5C89C7BDC2BFAF6D9AC93B10BE5");
  self.owner setsoundsubmix("_encstr_954E0F02DB781387F8379EA7C998CD9B9D", 1);

  if(!isDefined(self.enemiesmarked))
    self.enemiesmarked = [];

  if(!isDefined(self.usedcount))
    self.usedcount = 0;

  self.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_B8070A12833060F0C234F563", self.owner, undefined, self.owner, 0, 0, 0);
  self.ispiloted = 1;
  self.owner scripts\common\utility::allow_usability(0);
  self.owner scripts\common\utility::allow_fire(0);
  var_1 = 0;
  self.owner.restoreangles = self.owner.angles;
  self.owner setplayerangles(self.angles);
  self.owner cameralinkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.owner remotecontrolvehicle(self);
  self.owner painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::_id_11DC0(self.owner);

  if(!istrue(var_1)) {
    self.owner _id_131B7(1, self);
    self.owner setclientomnvar("_encstr_8E6E12FD1CB1A5515C4F5088CB754B47CB84F80C", 0);
    self.owner setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(self.timeout * 1000));
    self.owner setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", helperdrone_getcurrenthealth() / var_0.maxhealth);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_B8FC12989F6F28E7BBAFD64545934550C29FE991"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_B8FC12989F6F28E7BBAFD64545934550C29FE991")]](self, "_encstr_85CE0B9770B02C73A1760F06D2");

    thread monitoroutofboundsdistortion();

    if(0)
      scripts\cp_mp\outofrange::setupoutofrangewatcher(self, undefined, self.owner, undefined, 2250000, 9000000);

    scripts\cp_mp\utility\weapon_utility::setlockedoncallback(self, ::helperdrone_lockedoncallback);
    scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(self, ::helperdrone_lockedonremovedcallback);
    thread helperdrone_watchouterreticletargets(var_0);
    thread helperdrone_watchouterreticlestate(var_0);
    thread helperdrone_watchnotificationstate(var_0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_B4CB0D5B07A33271E08DB18AF7CA58"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_B4CB0D5B07A33271E08DB18AF7CA58")]](var_0);
    else
      thread helperdrone_markplayers(var_0);
  }

  self.owner scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  thread helperdrone_watchearlyexit(var_0);
  thread spawn_ai_func_ref(var_0);
  thread helperdrone_handlethermalswitch();
  thread spawn_acceleration(var_0);
  return 1;
}

_id_13128(var_0) {
  self.playersfx = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", self.origin);
  self.playersfx showonlytoplayer(self.owner);
  self.playersfx linkTo(self);
  self.playersfx playLoopSound("_encstr_937D14E4AC6CBDB9F5C89C7BDC2BFAF6D9AC93B10BE5");
  self.owner setsoundsubmix("_encstr_954E0F02DB781387F8379EA7C998CD9B9D", 1);
  self.targetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_A7500A8172D4D8079B6F0335", self.owner, undefined, self.owner, 0, 0, 0);
  self.ispiloted = 1;
  self.owner scripts\common\utility::allow_usability(0);
  self.owner scripts\common\utility::allow_fire(0);
  var_1 = 0;
  self.owner.restoreangles = self.owner.angles;
  self.owner setplayerangles(self.angles);
  self.owner cameralinkTo(self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.owner remotecontrolvehicle(self);
  self.owner painvisionoff();
  scripts\cp_mp\utility\killstreak_utility::_id_11DC0(self.owner);

  if(!istrue(var_1)) {
    self.owner _id_131B7(1, self);
    self.owner setclientomnvar("_encstr_8E6E12FD1CB1A5515C4F5088CB754B47CB84F80C", 0);
    self.owner setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(self.timeout * 1000));
    self.owner setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", helperdrone_getcurrenthealth() / var_0.maxhealth);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_B8FC12989F6F28E7BBAFD64545934550C29FE991"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_B8FC12989F6F28E7BBAFD64545934550C29FE991")]](self, "_encstr_85CE0B9770B02C73A1760F06D2");

    thread monitoroutofboundsdistortion();

    if(0)
      scripts\cp_mp\outofrange::setupoutofrangewatcher(self, undefined, self.owner, undefined, 2250000, 9000000);

    scripts\cp_mp\utility\weapon_utility::setlockedoncallback(self, ::helperdrone_lockedoncallback);
    scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback(self, ::helperdrone_lockedonremovedcallback);
    thread helperdrone_watchouterreticletargets(var_0);
    thread spawn_ai_individual(var_0);
    thread sp_stealth_broken_listener(var_0);
  }

  self playLoopSound("_encstr_A7C01B7B3BBE514791FBF160D020D5699103DED2E2B13042B9522F6BA0");
  self.owner scripts\cp_mp\utility\killstreak_utility::killstreak_savenvgstate();
  thread helperdrone_watchearlyexit(var_0);
  thread spawn_ai_func_ref(var_0);
  thread helperdrone_handlethermalswitch();
  thread spawn_acceleration(var_0);

  if(istrue(level.cargo_truck))
    thread sounddebouncetimestamp(2);

  return 1;
}

helperdrone_lockedoncallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("_encstr_A3FA0FA331A28318788F91DA3F678A5067", self.owner, "_encstr_85CE0B9770B02C73A1760F06D2");
}

helperdrone_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("_encstr_A3FA0FA331A28318788F91DA3F678A5067", self.owner, "_encstr_85CE0B9770B02C73A1760F06D2");
}

setoverwatchmodesettings(var_0) {
  thread helperdrone_overwatchplayer();
  thread helperdrone_pingnearbyenemies();
  helperdrone_handleteamvisibility();
  return 1;
}

setfollowmode(var_0) {
  thread helperdrone_followplayer();
  return 1;
}

setguardmode(var_0) {
  helperdrone_guardlocation();
  scramblerdrone_counteruavmodeon();
  helperdrone_handleteamvisibility();
  self setscriptablepartstate("_encstr_911B0D5CA222222C7088DF33797BA5", "_encstr_AB0703DBB9", 0);
  self setscriptablepartstate("_encstr_8DEB0D3EEB43A14B0E5A8851832739", "_encstr_AB0703DBB9", 0);
  self scriptmodelplayanim(level.scr_animname["_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD"]["_encstr_BA580B39BD1DED93EBDCC196E6"]);
  thread spawn_ai_single();
  return 1;
}

setdeliverymodesettings(var_0) {
  thread helperdrone_deliver(var_0);
  return 1;
}

helperdrone_deliver(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self setneargoalnotifydist(10);
  var_1 = level.helperdronesettings[self.helperdronetype].speed;
  var_2 = level.helperdronesettings[self.helperdronetype].accel;
  self vehicle_setspeed(var_1, var_2, var_2);
  var_3 = self.deliverytarget + (0, 0, 4000);
  var_4 = self.deliverytarget + (0, 0, 2500);
  var_5 = self.deliverytarget + (0, 0, 100);
  var_6 = level.helperdronesettings[self.helperdronetype].halfsize;
  var_7 = [];
  var_7[0] = self;
  var_8 = scripts\engine\trace::create_contents(1, 1, 1, 1);
  var_9 = scripts\engine\trace::sphere_trace(var_4, var_5, var_6, var_7, var_8, 0);
  var_10 = var_9["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"] + (0, 0, 100);
  self setvehgoalpos(var_10, 1);
  self waittill("_encstr_8B7205D9ED5958");
  wait 0.5;
  [[self.ondelivercallback]]();
  self vehicle_setspeedimmediate(2);
  self vehicle_setspeed(0.1, 1, 1);
  wait 0.5;
  self vehicle_setspeed(var_1, var_2, var_2);
  self setvehgoalpos(var_3, 0);
  self waittill("_encstr_8B7205D9ED5958");
  removehelperdrone(self.helperdronetype, var_0, 0);
}

helperdrone_getcurrenthealth() {
  var_0 = self.maxhealth;
  var_1 = var_0 - self.damagetaken;
  return int(max(0, var_1));
}

helperdrone_watchearlyexit(var_0) {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_99CC1EFA6008DF6BF748AF2BD457D995CE05C3E9AA98AB22E88B217B088B128B"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_99CC1EFA6008DF6BF748AF2BD457D995CE05C3E9AA98AB22E88B217B088B128B")]]("_encstr_AD75063D571AE108", var_0._id_1217E);

  self waittill("_encstr_A2DA0F6DD2B136CDD1275958B5A8E1D2A3");
  thread helperdroneexplode(0, istrue(var_0.leaderboarddata));
}

spawn_ai_func_ref(var_0) {
  if(!istrue(var_0.leaderinteractionthink)) {
    return;
  }
  var_1 = self.owner;
  var_1 notifyonplayercommand("_encstr_A1490FD10A8BE020163C8B8754BA603897", "_encstr_A9E60828803C73F11780");
  spawn_ai_group();

  if(isDefined(var_1))
    var_1 notifyonplayercommandremove("_encstr_A1490FD10A8BE020163C8B8754BA603897", "_encstr_A9E60828803C73F11780");
}

spawn_ai_group() {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  self.owner waittill("_encstr_A1490FD10A8BE020163C8B8754BA603897");
  thread helperdroneexplode(0, 1);
}

helperdrone_handlethermalswitch() {
  var_0 = self.owner;
  var_0 thread scripts\cp_mp\utility\player_utility::watchthermalinputchange();
  var_1 = 1;

  if(istrue(var_1)) {
    if(level.mapname == "_encstr_ACF70BABB3814330E4DF603B83")
      var_0 visionsetkillstreakforplayer("_encstr_A97011796A97884DF187CFC19F0B986031C26D");
    else
      var_0 visionsetkillstreakforplayer("_encstr_8BC40C048518FDFFC0198A4260AE");
  }

  var_0 visionsetthermalforplayer("_encstr_99C31C67C9D323570BE9939320592BB9B1D0A15BA37BFBB50E6887A73890");
  helperdrone_handlethermalswitchinternal();

  if(isDefined(var_0)) {
    var_0 scripts\cp_mp\utility\player_utility::stopwatchingthermalinputchange();

    if(istrue(var_1))
      var_0 visionsetkillstreakforplayer("_encstr_B40101");

    var_0 visionsetthermalforplayer("_encstr_B40101");

    if(self.isthermalenabled)
      var_0 thermalvisionoff();
  }
}

helperdrone_handlethermalswitchinternal() {
  var_0 = self.owner;
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  self.isthermalenabled = 0;

  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    self.isthermalenabled = 1;
    var_0 thermalvisionon();
  }

  for(;;) {
    var_0 waittill("_encstr_83DC143FAF8C707E6B3133B8FA6B2180652FBB8F2477");

    if(self.isthermalenabled) {
      self.isthermalenabled = 0;
      var_0 thermalvisionoff();
      var_0 playlocalsound("_encstr_847F1AA3CD4383D703D00F6BC099AC3931502FDF21E3C933E8301F07");
      continue;
    }

    self.isthermalenabled = 1;
    var_0 playlocalsound("_encstr_847F1AA3CD4383D703D00F6BC099AC3931502FDF21E3C933E8301F07");
    var_0 thermalvisionon();
  }
}

spawn_acceleration(var_0) {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");

  for(;;) {
    self waittill("_encstr_8D7D06302FE5E159", var_1);

    if(!isDefined(var_1)) {
      continue;
    }
    var_2 = undefined;

    if(var_1 scripts\cp_mp\vehicles\vehicle::isvehicle())
      var_2 = var_1;
    else if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle())
      var_2 = var_1.vehicle;
    else if(istrue(var_1.velstartid))
      var_2 = var_1;

    if(!isDefined(var_2)) {
      continue;
    }
    var_3 = istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self.owner, var_2.owner));

    if(istrue(var_0.leaderplunderstring)) {
      if(var_3 || !isDefined(var_2.owner))
        thread helperdroneexplode(0, 1);
      else
        self dodamage(self.maxhealth, var_2.origin, undefined, undefined, "_encstr_8D4E0A501FCB898912CB3FA3");
    } else {
      var_4 = undefined;
      var_5 = undefined;

      if(var_3) {
        var_6 = var_2.owner scripts\cp_mp\utility\player_utility::getvehicle();

        if(isDefined(var_6) && var_6 == var_2) {
          var_4 = var_2.owner;
          var_5 = var_2;
        }
      }

      self dodamage(self.maxhealth, var_2.origin, var_4, var_5, "_encstr_8D4E0A501FCB898912CB3FA3");
    }

    break;
  }
}

sounddebouncetimestamp(var_0) {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);
  self.owner thread scripts\cp_mp\utility\player_utility::ai_offhandfiremanager();
}

helperdrone_markplayers(var_0) {
  var_1 = self.owner;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  var_2 = 0;

  for(;;) {
    self.targethascoldblooded = 0;
    self.targetisnotinmarkingrange = 0;
    self.c130airdrop_findvaliddroplocation = 0;
    var_3 = self.targetsinouterradius;

    foreach(var_5 in var_3) {
      if(var_2 >= 3) {
        var_2 = 0;
        waitframe();
      }

      if(isPlayer(var_5) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")]](var_5))
          continue;
      }

      if(isagent(var_5) && !isalive(var_5)) {
        continue;
      }
      if(!isDefined(var_5)) {
        continue;
      }
      if(isbeingmarked(var_5)) {
        continue;
      }
      if(isreconmarked(var_5)) {
        continue;
      }
      var_2++;
      _id_131C9(self.targetmarkergroup, var_5, 1);
      var_6 = canseetarget(var_5);
      var_7 = var_1 helperdrone_istargetinreticle(var_5, 70, 40);
      var_8 = isinmarkingrange(var_5);
      var_9 = 0;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
        if(isPlayer(var_5) && var_5[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9"))
          var_9 = 1;
      }

      if(var_7 && var_9)
        self.targethascoldblooded = 1;

      if(var_7 && !var_8)
        self.targetisnotinmarkingrange = 1;

      if(var_8)
        self.c130airdrop_findvaliddroplocation = 1;

      if(var_9) {
        _id_131C9(self.targetmarkergroup, var_5, 3);
        continue;
      }

      if(!var_8 || !var_6) {
        _id_131C9(self.targetmarkergroup, var_5, 0);
        continue;
      }

      if(!var_7) {
        continue;
      }
      if(istrue(self.markingtarget)) {
        continue;
      }
      thread startmarkingtarget(var_5, "_encstr_88BF06FD784A6393", 0, 1);
    }

    var_2 = 0;
    waitframe();
  }
}

sp_stealth_broken_listener(var_0) {
  var_1 = self.owner;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  var_2 = 0;

  for(;;) {
    var_3 = self.targetsinouterradius;
    var_4 = 0;

    foreach(var_6 in var_3) {
      if(var_2 >= 3) {
        var_2 = 0;
        waitframe();
      }

      if(!isDefined(var_6)) {
        continue;
      }
      if(isPlayer(var_6) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")) {
        if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")]](var_6))
          continue;
      }

      var_2++;
      _id_131C9(self.targetmarkergroup, var_6, 1);
      var_7 = canseetarget(var_6);
      var_8 = isinmarkingrange(var_6);

      if(!var_8 || !var_7) {
        _id_131C9(self.targetmarkergroup, var_6, 0);
        continue;
      }

      var_4 = 1;
      _id_131C9(self.targetmarkergroup, var_6, 2);
    }

    self._id_13A79 = var_4;
    var_2 = 0;
    waitframe();
  }
}

helperdrone_watchouterreticlestate(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = 0;

  for(;;) {
    if(istrue(self.markingtarget) && var_1 == 0) {
      self.owner setclientomnvar("_encstr_8E6E12FD1CB1A5515C4F5088CB754B47CB84F80C", 1);
      var_1 = 1;
    } else if(!istrue(self.markingtarget) && var_1 == 1) {
      self.owner setclientomnvar("_encstr_8E6E12FD1CB1A5515C4F5088CB754B47CB84F80C", 0);
      var_1 = 0;
    }

    waitframe();
  }
}

spawn_ai_individual(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = 0;

  for(;;) {
    if(istrue(self._id_13A79) && var_1 == 0) {
      self.owner setclientomnvar("_encstr_8E6E12FD1CB1A5515C4F5088CB754B47CB84F80C", 1);
      var_1 = 1;
    } else if(!istrue(self._id_13A79) && var_1 == 1) {
      self.owner setclientomnvar("_encstr_8E6E12FD1CB1A5515C4F5088CB754B47CB84F80C", 0);
      var_1 = 0;
    }

    waitframe();
  }
}

helperdrone_watchnotificationstate(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");

  for(;;) {
    if(istrue(self.targethascoldblooded))
      self.owner setclientomnvar("_encstr_990114B3447FB0966A4FE59F9BC26C201BDE1B886DA6", 3);
    else if(istrue(self.targetisnotinmarkingrange))
      self.owner setclientomnvar("_encstr_990114B3447FB0966A4FE59F9BC26C201BDE1B886DA6", 1);
    else if(!istrue(self.c130airdrop_findvaliddroplocation))
      self.owner setclientomnvar("_encstr_990114B3447FB0966A4FE59F9BC26C201BDE1B886DA6", 2);
    else
      self.owner setclientomnvar("_encstr_990114B3447FB0966A4FE59F9BC26C201BDE1B886DA6", 0);

    waitframe();
  }
}

helperdrone_watchouterreticletargets(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self.targetsinouterradius = [];

  for(;;) {
    var_1 = level.activekillstreaks;
    var_2 = [[level.getactiveequipmentarray]]();
    var_3 = level.characters;

    if(isDefined(level.battle_tracks_shouldstartbattletracks)) {
      var_4 = [];

      foreach(var_6 in level.battle_tracks_shouldstartbattletracks) {
        if(isDefined(var_6.iscash)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_A75F0924F92F312DBDBA88")) {
            if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_A75F0924F92F312DBDBA88")]]("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
              if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_ABCD195A3714C6162FB2939E3725B93A598D86D085C68DACCD3B95")) {
                if([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_ABCD195A3714C6162FB2939E3725B93A598D86D085C68DACCD3B95")]](self.owner, var_6.iscash))
                  var_4[var_4.size] = var_6;
              }
            }
          }

          continue;
        }

        var_4[var_4.size] = var_6;
      }

      var_8 = scripts\engine\utility::array_combine(var_3, var_4);
    } else
      var_8 = var_3;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_B8921A9DAC1DBEDB57E85639F527CA47D26CD859FA1D85399DCAE837"))
      var_8 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_B8921A9DAC1DBEDB57E85639F527CA47D26CD859FA1D85399DCAE837")]](var_0);

    foreach(var_10 in var_8) {
      if(isPlayer(var_10)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")) {
          if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")]](var_10))
            continue;
        }

        if(!istrue(var_0._id_11B06)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
            if(var_10[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9"))
              continue;
          }
        }
      }

      if(isagent(var_10) && !isalive(var_10)) {
        continue;
      }
      if(level.teambased) {
        if(isDefined(var_10.team) && var_10.team == self.team)
          continue;
      } else {
        if(isPlayer(var_10) && var_10 == self.owner) {
          continue;
        }
        if(isDefined(var_10.owner) && var_10.owner == self.owner)
          continue;
      }

      if(!isindetectrange(var_10)) {
        continue;
      }
      if(isreconmarked(var_10)) {
        continue;
      }
      if(isinouterradius(self, var_10)) {
        continue;
      }
      var_0 = level.helperdronesettings[self.helperdronetype];

      if(istrue(var_0._id_11B07) && !self.owner helperdrone_istargetinreticle(var_10, 70, 300)) {
        continue;
      }
      thread startmarkingpassivetarget(var_10);
    }

    waitframe();
  }
}

canseetarget(var_0) {
  var_1 = 0;

  if(isDefined(var_0._id_12A9B))
    var_2 = var_0._id_12A9B;
  else
    var_2 = scripts\engine\trace::create_contents(0, 1, 0, 1, 1, 1, 0, 1);

  var_3 = var_0.origin;

  if(isDefined(var_0._id_12A9C))
    var_3 = var_3 + var_0._id_12A9C;

  var_4 = [var_3];

  if(isPlayer(var_0)) {
    var_5 = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56"))
      var_5 = var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_93E50D674D73B7EB3398D28A7117A2")]]();

    var_6 = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56"))
      var_6 = var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AD3610BA61F59FCBD03D8B957F2895CB957B")]]();

    var_4 = [var_5, var_6, var_3];
  } else if(isagent(var_0))
    var_4 = [var_3 + (0, 0, 1)];

  var_7 = [self, var_0];
  var_8 = var_0 scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(var_8)) {
    var_7[var_7.size] = var_8;
    var_9 = var_8 getlinkedchildren(1);

    foreach(var_11 in var_9)
    var_7[var_7.size] = var_8;
  }

  for(var_13 = 0; var_13 < var_4.size; var_13++) {
    if(!scripts\engine\trace::ray_trace_passed(self.owner getvieworigin(), var_4[var_13], var_7, var_2)) {
      continue;
    }
    var_1 = 1;
    break;
  }

  return var_1;
}

startmarkingpassivetarget(var_0) {
  var_1 = self.owner;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");

  if(!isDefined(self.targetmarkergroup)) {
    return;
  }
  self.targetsinouterradius[self.targetsinouterradius.size] = var_0;
  scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_0, self.targetmarkergroup, 0);
  _id_131C9(self.targetmarkergroup, var_0, 0);

  while(isDefined(var_0)) {
    if(isPlayer(var_0) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")) {
      if(![[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56")]](var_0)) {
        break;
      }
    }

    if(isagent(var_0) && !isalive(var_0)) {
      break;
    }

    var_2 = level.helperdronesettings[self.helperdronetype];

    if(istrue(var_2._id_11B07) && !self.owner helperdrone_istargetinreticle(var_0, 70, 300)) {
      break;
    }

    if(!isindetectrange(var_0)) {
      break;
    }

    waitframe();
  }

  if(isDefined(var_0)) {
    if(scripts\cp_mp\targetmarkergroups::targetmarkergroupexists(self.targetmarkergroup) && !isreconmarked(var_0))
      scripts\cp_mp\targetmarkergroups::targetmarkergroup_unmarkentity(var_0, var_0 getentitynumber(), self.targetmarkergroup);

    if(scripts\engine\utility::array_contains(self.targetsinouterradius, var_0))
      self.targetsinouterradius = scripts\engine\utility::array_remove(self.targetsinouterradius, var_0);
  } else
    self.targetsinouterradius = scripts\engine\utility::array_removeundefined(self.targetsinouterradius);
}

startmarkingtarget(var_0, var_1, var_2, var_3) {
  var_4 = self.owner;
  var_4 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  var_5 = spawnStruct();
  var_5.target = var_0;
  var_5.targetnum = var_0 getentitynumber();
  var_5.markingent = self;
  var_5.ownerteam = var_4.team;
  var_5.outlineid = undefined;
  var_5.headicon = undefined;
  var_5.beingmarked = undefined;
  var_5.reconmarked = undefined;
  var_5.notifytoendmark = "_encstr_BDA60A23731A7F40B3876906" + var_5.targetnum;

  if(!isDefined(var_5.targetnum)) {
    return;
  }
  if(!isDefined(self.targetmarkergroup)) {
    return;
  }
  var_5.beingmarked = 1;
  self.markingtarget = 1;
  self.owner notify("_encstr_921D0FCBD1C8481B52778FDB7BA3D9101B");
  self.owner _id_131B7(2, self);
  var_6 = getmarkingdelay(var_0);
  self.owner playlocalsound("_encstr_9A371AC5C5F96AC5B11F4338F61DB1E73193AA80B0BC11A013AAF5FB");

  while(var_6 > 0) {
    if(!isDefined(var_0)) {
      return;
    }
    if(!var_4 helperdrone_istargetinreticle(var_0, 70, 40)) {
      var_5.beingmarked = undefined;
      self.markingtarget = undefined;
      self.owner stoplocalsound("_encstr_9A371AC5C5F96AC5B11F4338F61DB1E73193AA80B0BC11A013AAF5FB");
      self.owner _id_131B7(1, self);
      return;
    }

    var_6 = var_6 - 0.05;
    wait 0.05;
  }

  if(isDefined(var_0._id_12A99))
    [[var_0._id_12A99]](var_4, var_0);

  var_5.reconmarked = 1;
  self.markingtarget = undefined;
  markent(var_5, undefined);
  self.owner playlocalsound("_encstr_887C19C9B2C6BD73AF234EF6E695BEB50B276D2B327D7BBBE6CA27");
  self.owner stoplocalsound("_encstr_9A371AC5C5F96AC5B11F4338F61DB1E73193AA80B0BC11A013AAF5FB");
  self.owner _id_131B7(4, self);
  _id_131C9(self.targetmarkergroup, var_0, 2);
  addmarkpoints(var_0, var_1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_AC0D05331DCB3B", "_encstr_8D310C2D73B14156E46EA93AB08E"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_AC0D05331DCB3B", "_encstr_8D310C2D73B14156E46EA93AB08E")]]("_encstr_A1DB1015333230A545C3C855DFB5F9508F4F", 1);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_826B166310C589B9786A118FF71BCF8363A012FA706B1B0A"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_826B166310C589B9786A118FF71BCF8363A012FA706B1B0A")]]("_encstr_955F12039B0FAFA2B9AD353BBF18A113B6704AEA");

  self.usedcount++;
  var_7 = 5.0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
    if(self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_92CB1FCD0EB21BA5B063D12FAFD2D63827B73B5923FAE85839ECCAE8EB5B1627D6"))
      var_7 = var_7 + 2;
  }

  thread waituntilunmarked(var_5, var_7);
}

addmarkpoints(var_0, var_1) {
  if(!isDefined(self.markedentitieslifeindicices))
    self.markedentitieslifeindicices = [];

  var_2 = var_0 getentitynumber();
  var_3 = scripts\engine\utility::ter_op(isDefined(self.matchdatalifeindex), self.matchdatalifeindex, 0);

  if(!isDefined(self.markedentitieslifeindicices[var_2]) || self.markedentitieslifeindicices[var_2] > var_3) {
    self.markedentitieslifeindicices[var_2] = var_3;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_AA8E12846C53FB87468728589F64FF374A558516"))
      self.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AA8E12846C53FB87468728589F64FF374A558516")]](self.helperdronetype + "_encstr_BA4C02DF" + var_1 + "_encstr_A1E708D781F1E04B3088");
  }
}

waituntilunmarked(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = var_0.target;
  var_2 endon(var_0.notifytoendmark);
  waituntilunmarkedinternal(var_0, var_1);
  unmark(var_0);
}

waituntilunmarkedinternal(var_0, var_1) {
  var_2 = self.owner;
  var_2 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_3 = var_0.target;
  var_3 endon("_encstr_AD75063D571AE108");
  var_4 = gettime();

  while(var_1 * 1000 + var_4 >= gettime()) {
    wait 0.05;

    if(isDefined(self) && isDefined(self.owner) && self.owner helperdrone_istargetinreticle(var_3, 70, 40) && isinmarkingrange(var_3) && canseetarget(var_3))
      var_4 = gettime();
  }
}

resetreticlemarkingprogressstate(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self endon("_encstr_A69B0D1B03D755707C3F838F2C67A8");
  var_1 = self.owner;
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 endon("_encstr_921D0FCBD1C8481B52778FDB7BA3D9101B");
  wait(var_0);
  self.owner _id_131B7(1, self);
}

islocationmarked(var_0) {
  return istrue(var_0.locationmarked);
}

isinouterradius(var_0, var_1) {
  return scripts\engine\utility::array_contains(var_0.targetsinouterradius, var_1);
}

isbeingmarked(var_0) {
  if(!isDefined(self.enemiesmarked))
    return 0;

  var_1 = self.enemiesmarked[var_0 getentitynumber()];

  if(!isDefined(var_1))
    return 0;

  return isDefined(var_1.beingmarked);
}

isreconmarked(var_0) {
  if(!isDefined(self.enemiesmarked))
    return 0;

  var_1 = self.enemiesmarked[var_0 getentitynumber()];

  if(!isDefined(var_1))
    return 0;

  return istrue(var_1.reconmarked);
}

isinmarkingrange(var_0) {
  var_1 = level.helperdronesettings[self.helperdronetype];
  var_2 = scripts\cp_mp\utility\game_utility::islargemap();
  var_3 = scripts\engine\utility::ter_op(var_2, var_1._id_11B18, var_1._id_11B17);

  if(isDefined(var_0._id_11B08))
    var_3 = var_0._id_11B08;

  var_4 = var_0.origin;

  if(isPlayer(var_0)) {
    var_4 = (0, 0, 0);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_B21E0EB49B49CAB01B8D9782365AEC56"))
      var_4 = var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_AD3610BA61F59FCBD03D8B957F2895CB957B")]]();
  }

  return distancesquared(self.origin, var_4) < var_3;
}

isindetectrange(var_0) {
  return distancesquared(self.origin, var_0.origin) < 25000000;
}

getmarkingdelay(var_0) {
  return 0.3;
}

marklocation(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.target = var_0;
  var_4.targetnum = var_0 getentitynumber();
  var_4.outlineid = undefined;
  var_4.headicon = undefined;
  var_5 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_1);
  var_5 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_6 = undefined;

  if(level.teambased) {
    var_6 = [];

    foreach(var_8 in level.players) {
      if(!isDefined(var_8)) {
        continue;
      }
      if(var_8.team != self.team) {
        continue;
      }
      var_6[var_6.size] = var_8;
    }
  } else
    var_6 = self.owner;

  if(!isDefined(var_6)) {
    return;
  }
  if(isarray(var_6) && var_6.size == 0) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_10 = 0;
    var_11 = 5000;
    var_12 = 500;
  } else {
    var_10 = 1;
    var_11 = 5000;
    var_12 = 500;
  }

  if(1)
    var_4.headicon = var_5 thread scripts\cp_mp\entityheadicons::setheadicon_singleimage(var_6, "_encstr_96321214C71FF589CDD31BCE79D3311565109703", 15, var_10, var_11, var_12, undefined, 1, 1);

  thread marklocation_watchmarkentstatus(var_4, var_5, var_3);
}

earlyremoveradarperk(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  waitframe();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
    if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]](var_0)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_A5D80B27595BF69D2B289593AD")]](var_0);
    }
  }
}

marklocation_watchmarkentstatus(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::_id_143BA(var_2, "_encstr_AD75063D571AE108", "_encstr_860808CB78E2984063BA");

  if(isDefined(var_0.icon)) {
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_0.icon);

    if(isDefined(var_1))
      var_1 delete();
  }

  if(isDefined(var_0.target))
    var_0.target.locationmarked = undefined;

  self.enemiesmarked[var_0.targetnum] = undefined;
}

markent(var_0, var_1) {
  var_2 = var_0.target;
  self.enemiesmarked[var_0.targetnum] = var_0;
  var_3 = "_encstr_86A815A15732FA2DB1DEB9BE43ACB08CAFB5584EB5ACC8";
  var_4 = 8;

  if(isPlayer(var_2)) {
    if(0) {
      if(level.teambased) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_ABFE150D7B70BC5AF00BAF0B6BAE52ED4980C25B912075"))
          var_0.outlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_ABFE150D7B70BC5AF00BAF0B6BAE52ED4980C25B912075")]](var_2, "_encstr_B8BC07D01BBF370877", self.owner.team, 0, 1, 0, "_encstr_85CE0B9770B02C73A1760F06D2");
      } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_974217BDCBC00CCA609B5FFBFB1EE27D391072CA40B0D1C246"))
        var_0.outlineid = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_974217BDCBC00CCA609B5FFBFB1EE27D391072CA40B0D1C246")]](var_2, "_encstr_B8BC07D01BBF370877", self.owner, 0, 1, 0, "_encstr_85CE0B9770B02C73A1760F06D2");

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_86DA1A34AEC8F4AB47D8A53795ACB459BBDADEC8B21B8A730B2663B2"))
        var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_86DA1A34AEC8F4AB47D8A53795ACB459BBDADEC8B21B8A730B2663B2")]](5, 0, 1);
    }

    var_2 thread markflash();
    var_2 markeduion();
    var_2 playlocalsound("_encstr_A14D18130AD7E020992CA5E75E7FE1B6C3026B5B922330086D12");
  } else {
    var_5 = markent_getweaponicon(var_3, var_4, var_2);
    var_3 = var_5.weaponicon;
    var_4 = var_5.weaponoffset;
  }

  if(scripts\cp_mp\utility\game_utility::isrealismenabled()) {
    var_6 = 0;
    var_7 = 4000;
    var_8 = 500;
  } else {
    var_6 = 1;
    var_7 = 4000;
    var_8 = 500;
  }

  if(1) {
    var_0.headicon = var_2 scripts\cp_mp\entityheadicons::setheadicon_singleimage([], var_3, var_4, var_6, var_7, var_8, undefined, 1, 1);
    markupdateheadiconallplayers(var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_A2CE16BBB03A8D1A531627DA4BE6D951E63AA6A358D1EADC"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_A2CE16BBB03A8D1A531627DA4BE6D951E63AA6A358D1EADC")]](var_0);

  thread resetreticlemarkingprogressstate(getmarkingdelay(var_0.target));
}

_id_131B7(var_0, var_1) {
  var_2 = 0;

  if(isDefined(var_1))
    var_2 = var_1.helperdronetype == "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B";

  if(var_0 > 0 && var_2)
    var_0 = var_0 + 4;

  self setclientomnvar("_encstr_ABD71088F34932B7E97F1FFD45236308F180", var_0);
  self notify("_encstr_9B32161071364D67333FABB056123E91E7B028471D27F731", var_0);
}

_id_131C9(var_0, var_1, var_2) {
  var_3 = (var_2 >> 0) % 2 == 1;
  var_4 = (var_2 >> 1) % 2 == 1;
  targetmarkergroupsetextrastate(var_0, var_1, var_3);
  addclienttotargetmarkergroupmask(var_0, var_1, var_4);
}

markflash() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(!istrue(self.iszombie)) {
    self visionsetnakedforplayer("_encstr_932412DD5DEE4818576253F8EA9758D8C5B12761", 0.05);
    wait 0.08;
    scripts\mp\utility\player::restorebasevisionset(1.2);
  }
}

markeduion() {
  if(!isDefined(self.markedomnvar)) {
    self.markedomnvar = 1;
    self setclientomnvar("_encstr_B81115C3DFC1DB481F7764911B0FBDC317882064779E6B", self.markedomnvar);
    thread watchmarkedui();
  } else {
    if(self.markedomnvar == 1)
      self.markedomnvar = 2;
    else
      self.markedomnvar = 1;

    self setclientomnvar("_encstr_B81115C3DFC1DB481F7764911B0FBDC317882064779E6B", self.markedomnvar);
  }
}

watchmarkedui() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notify("_encstr_A1210F1B47E372E0B483F44FF29C08354A");
  self endon("_encstr_A1210F1B47E372E0B483F44FF29C08354A");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_AC07157F27F318D0A15AA03E838109CD5BD3EBD1EFAA58"))
    wait(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8E3D0D86CA1B835939BEC839DEB9AC", "_encstr_AC07157F27F318D0A15AA03E838109CD5BD3EBD1EFAA58")]]());
  else
    wait 3;

  thread markeduioff();
}

markeduioff() {
  self notify("_encstr_A1210F1B47E372E0B483F44FF29C08354A");
  self.markedomnvar = undefined;
  self setclientomnvar("_encstr_B81115C3DFC1DB481F7764911B0FBDC317882064779E6B", 0);
}

markent_getweaponicon(var_0, var_1, var_2) {
  var_3 = var_0;
  var_4 = var_1;
  var_5 = spawnStruct();

  if(isDefined(var_2.weapon_name)) {
    var_6 = undefined;

    if(issubstr(var_2.weapon_name, "_encstr_9BD1091BC62CBCB5F6E4CA"))
      var_6 = "_encstr_82A70F2B3B73E33B472371FF21D7809DDF";
    else if(issubstr(var_2.weapon_name, "_encstr_8B07036CD0"))
      var_6 = "_encstr_843D095F2B7D52B041D9A3";
    else if(issubstr(var_2.weapon_name, "_encstr_8DD607A129A99C737D"))
      var_6 = "_encstr_886E0ECA2ED5B438FAB0A3D7B5B4CD95";
    else if(issubstr(var_2.weapon_name, "_encstr_9BB4074B8EEF3942D8"))
      var_6 = "_encstr_AA870D15FAF37393C74318F8BB184A";

    if(isDefined(var_6)) {
      var_7 = undefined;

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D8516C9550B77083D13DB0832457BEF714BB4D9176042EF"))
        var_7 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8D8516C9550B77083D13DB0832457BEF714BB4D9176042EF")]](var_6);

      var_3 = var_7.image;
    }
  } else if(isDefined(var_2.streakinfo)) {
    var_8 = var_2.streakinfo.streakname;
    var_3 = game["_encstr_BE9E1042AC3229839C2BF0D86794996D5AD7"].tabledatabyref[var_8]["_encstr_8FAE0D7BECCA4ED05958C892B1B737"];
    var_4 = 75;
  }

  var_5.weaponicon = var_3;
  var_5.weaponoffset = var_4;
  return var_5;
}

markupdateheadiconallplayers(var_0) {
  foreach(var_2 in level.players) {
    if(!isDefined(var_2)) {
      return;
    }
    markupdateheadicon(var_0, var_2);
  }
}

markupdateheadicon(var_0, var_1) {
  var_2 = scripts\mp\utility\player::isfriendly(var_0.ownerteam, var_1);
  var_3 = isDefined(var_0.markingent) && isDefined(var_0.markingent.owner) && var_1 == var_0.markingent.owner;
  var_4 = isDefined(var_0.markingent) && istrue(var_0.markingent.ispiloted);
  var_5 = var_3 && var_4;

  if(isDefined(var_0.headicon)) {
    if(var_2 && !var_5)
      scripts\cp_mp\entityheadicons::_id_1315D(var_0.headicon, var_1);
    else
      scripts\cp_mp\entityheadicons::_id_1315E(var_0.headicon, var_1);
  }
}

unmark(var_0) {
  scripts\cp_mp\entityheadicons::setheadicon_deleteicon(var_0.headicon);

  if(isDefined(var_0.target)) {
    var_0.reconmarked = undefined;
    var_0.beingmarked = undefined;

    if(isDefined(self))
      self.enemiesmarked[var_0.targetnum] = undefined;

    if(isPlayer(var_0.target) && 0) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_BABB0FDED51D632DE62B11A5B90BC4D8CA")]](var_0.outlineid, var_0.target);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8D360838D3CB51A8EEEF", "_encstr_A5D21B0DEAC89ED547C696DC95659659BB6BDB91CAB188D2B90BC4C656"))
        var_0.target[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8D360838D3CB51A8EEEF", "_encstr_A5D21B0DEAC89ED547C696DC95659659BB6BDB91CAB188D2B90BC4C656")]]();
    }

    var_0.target notify(var_0.notifytoendmark);
  } else if(isDefined(self))
    self.enemiesmarked[var_0.targetnum] = undefined;
}

helperdrone_watchforgoal() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self.owner endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8B460B3A23F8474A212F879E33");
  self notify("_encstr_A3FF19B0B1D8A3F8A3D48E42D0EF81172F15E07B104FE2BC88D73B");
  self endon("_encstr_A3FF19B0B1D8A3F8A3D48E42D0EF81172F15E07B104FE2BC88D73B");
  var_0 = scripts\engine\utility::_id_143AE("_encstr_8B7205D9ED5958", "_encstr_B4D10ADC950BE4EB76DE8536", "_encstr_A184092A6AB82E9ADF42F1");
  self.intransit = 0;
  self.inactive = 0;
  self notify("_encstr_A184092A6AB82E9ADF42F1");
}

helperdrone_watchdamage() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8B460B3A23F8474A212F879E33");
  self.health = 2147483647;
  var_0 = self.maxhealth;
  var_1 = level.helperdronesettings[self.helperdronetype];

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);

    if(isDefined(var_3)) {
      if(isDefined(var_3.owner))
        var_3 = var_3.owner;

      if(isDefined(var_3.team) && var_3.team == self.team && var_3 != self.owner)
        continue;
    }

    if(isDefined(var_11)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2"))
        var_2 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_A1F220D92BD1D4BD462D99B4B2910AE63A96D296D81BCDD1E42B16B58858B516ECB2")]](var_3, var_11, var_6, var_2, var_1.maxhealth, 1, 1, 1);
    }

    var_0 = var_0 - var_2;

    if(isPlayer(var_3)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA"))
        var_3[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_B8BD15933BAB8790776CE3C371DFD0CC778249F9B21FCA")]]("_encstr_B40101");

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B2D0E10DA55893B8B12D5DF13A3A071"))
        [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_8B2D0E10DA55893B8B12D5DF13A3A071")]](var_3, var_11, self, var_6, var_2);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_A2CC1636B7B3051D1D1636DA2B27D25AC636E6A39C95C2DA"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_A2CC1636B7B3051D1D1636DA2B27D25AC636E6A39C95C2DA")]](self, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

      if(var_0 <= 0) {
        var_3 notify("_encstr_8B2B15681A92B91BE719D55D272FA041BD836040B2AEDF", var_11);
        var_16 = var_2;
        var_17 = self.streakinfo.streakname;
        var_18 = undefined;
        var_19 = 1;

        if(isDefined(var_11)) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24"))
            var_20 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B2BE0788BAF573592F", "_encstr_8CED1307B60498F97BF333FBFA2722D1241CB99B24")]](self.helperdronetype, var_3, var_11, var_18, var_16, var_1.scorepop, var_1.vodestroyed, var_1.destroyedsplash, var_19);
        }

        thread helperdroneexplode(1);
      }
    }

    if(var_0 <= int(self.maxhealth / 1.2) && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_AB0703DBB9");
      continue;
    }

    if(var_0 <= int(self.maxhealth / 2) && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_AB0703DBB9");
      continue;
    }

    if(var_0 <= int(self.maxhealth / 3) && self.currentdamagestate == 2) {
      self.currentdamagestate = 3;
      self setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_AB0703DBB9");
    }
  }
}

helperdrone_watchtimeout() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8B460B3A23F8474A212F879E33");
  var_0 = level.helperdronesettings[self.helperdronetype];
  self.timeout = var_0.timeout;

  if(!isDefined(self.timeout)) {
    return;
  }
  if(self.timeout > 0) {
    self.owner setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", gettime() + int(self.timeout * 1000));
    wait(self.timeout);
  }

  scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog(var_0.votimedout, 1);
  thread helperdrone_leave();
}

helperdrone_watchownerloss() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  childthread helperdrone_watchownerstatus("_encstr_8D820B49520F0EC02DDE6367EC");
  childthread helperdrone_watchownerstatus("_encstr_81170C244F9CBDE72C01BB99A298");
  childthread helperdrone_watchownerstatus("_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");

  if(self.helperdronetype != "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD")
    childthread helperdrone_watchownerstatus("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
}

helperdrone_watchownerstatus(var_0) {
  self.owner waittill(var_0);
  self notify("_encstr_8B460B3A23F8474A212F879E33");
  thread helperdrone_leave();
}

helperdrone_watchownerdeath() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");

  for(;;) {
    self.owner waittill("_encstr_AD75063D571AE108");
    var_0 = level.helperdronesettings[self.helperdronetype];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_BA7714A8BBFD7D30A2DFA8F8B94296071895313315B7")) {
      if(istrue(var_0.diewithowner) || [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_BA7714A8BBFD7D30A2DFA8F8B94296071895313315B7")]]() && self.owner.pers["_encstr_8E0607055DBFB3919A"] == [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_BA7714A8BBFD7D30A2DFA8F8B94296071895313315B7")]]())
        thread helperdrone_leave();
    }
  }
}

helperdrone_watchroundend() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_8B460B3A23F8474A212F879E33");
  level scripts\engine\utility::_id_143A6("_encstr_85571343573D62E481D9F57FB66021DA9BC7B39739", "_encstr_9B1D0BC7932875276230426AA1", "_encstr_AD9F1168238D48239B0EFB68667263B1FE57F0");
  thread helperdrone_leave();
}

helperdrone_leave() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_860808CB78E2984063BA");

  if(self.helperdronetype == "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60") {
    self clearlookatent();
    self setmaxpitchroll(0, 0);
    self notify("_encstr_BA2D081B2B58B32D37EC");
    self vehicle_setspeed(50, 25);
    var_0 = self.origin + anglesToForward((0, randomint(360), 0)) * 500;
    var_0 = var_0 + (0, 0, 1000);
    self setvehgoalpos(var_0, 1);
    self setneargoalnotifydist(100);
    self waittill("_encstr_B4D10ADC950BE4EB76DE8536");
    var_1 = helperdrone_getpathend();
    self vehicle_setspeed(150, 50);
    self setvehgoalpos(var_1, 1);
    self waittill("_encstr_8B7205D9ED5958");
    self notify("_encstr_8772059DDEDCAC");
    removehelperdrone(self.helperdronetype, level.helperdronesettings[self.helperdronetype], 0);
  } else
    thread helperdroneexplode(0);
}

helperdrone_getpathend() {
  var_0 = 150;
  var_1 = 15000;
  var_2 = self.angles[1];
  var_3 = (0, var_2, 0);
  var_4 = self.origin + anglesToForward(var_3) * var_1;
  return var_4;
}

perkengineer_manageminimap() {
  var_0 = "_encstr_A3F81CAB3BA59EA9588C80BA074F1B7662CBE8275D406B656650F53FDDE1";
  self.enemyobjid = scripts\mp\objidpoolmanager::createobjective_engineer(var_0, 1, 1);

  foreach(var_2 in level.players) {
    if(!isPlayer(var_2)) {
      continue;
    }
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")) {
      if(var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_960D052F10EBF0", "_encstr_88C90886B09B822B9CDA")]]("_encstr_9B63139B09C036574770439BFEAD93EF088D051565") && var_2.team != self.team) {
        if(self.enemyobjid != -1)
          scripts\mp\objidpoolmanager::objective_playermask_addshowplayer(self.enemyobjid, var_2);
      }
    }
  }
}

helperdrone_modifydamageresponse(var_0) {
  helperdrone_modifydamagestates(var_0);
  var_1 = var_0.meansofdeath;
  var_2 = var_0.damage;

  if(isDefined(self.owner) && self.owner scripts\cp_mp\utility\player_utility::isusingremote()) {
    if(isexplosivedamagemod(var_1)) {
      if(ceil(var_2 / self.maxhealth) >= 0.4) {
        earthquake(0.25, 0.2, self.origin, 150);
        self.owner playRumbleOnEntity("_encstr_B4BE0D8C58DAB09DCA7D342BB03BCB");
      } else {
        earthquake(0.15, 0.15, self.origin, 150);
        self.owner playRumbleOnEntity("_encstr_B14F0D7B2B51F287F03ED59C51F0DC");
      }
    }
  }

  return 1;
}

helperdrone_modifydamagestates(var_0) {
  var_1 = var_0.damage;
  self.currenthealth = self.health - var_1;

  if(self.currenthealth <= int(self.maxhealth / 1.2) && self.currentdamagestate == 0) {
    self.currentdamagestate = 1;
    self setscriptablepartstate("_encstr_A5291219482C48E9A0CEC2928F6DBE0A979F9873", "_encstr_AB0703DBB9");
  } else if(self.currenthealth <= int(self.maxhealth / 2) && self.currentdamagestate == 1) {
    self.currentdamagestate = 2;
    self setscriptablepartstate("_encstr_ABBC1331BD462FF51916AD583B56FAB62B462DD5D6", "_encstr_AB0703DBB9");
  } else if(self.currenthealth <= int(self.maxhealth / 3) && self.currentdamagestate == 2) {
    self.currentdamagestate = 3;
    self setscriptablepartstate("_encstr_AD411231DB23CBBE8CC2D616B395AFA1ACB0ECE5", "_encstr_AB0703DBB9");
  }

  self.owner setclientomnvar("_encstr_8B4F1557D2F5B6D236C637E839AC2CDABE0DB2B0B11D1A", self.currenthealth / self.maxhealth);
  return 1;
}

helperdrone_stunned(var_0) {
  self notify("_encstr_ABB214A15663E056392293B73795FACDA3579BE6958C");
  self endon("_encstr_ABB214A15663E056392293B73795FACDA3579BE6958C");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(istrue(self.attackingtarget))
    self notify("_encstr_99461198AC47113828C94F2BB1A3BEF2823B88");

  self.stunned = 1;

  if(isDefined(level.helperdronesettings[self.helperdronetype].fxid_sparks))
    playFXOnTag(level.helperdronesettings[self.helperdronetype].fxid_sparks, self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");

  playFXOnTag(scripts\engine\utility::getfx("_encstr_9B12096789A1B13BC3F8E3"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_9B12096789A1B13BC3F8E3"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  self.stunned = 0;
}

helperdronedestroyed(var_0) {
  if(!isDefined(self) || istrue(self.isdestroyed)) {
    return;
  }
  thread helperdroneexplode(1);
  return 0;
}

helperdroneexplode(var_0, var_1) {
  self.isdestroyed = 1;
  var_2 = level.helperdronesettings[self.helperdronetype];
  helperdrone_endscramblereffect();

  if(isDefined(self.minimapid)) {
    scripts\mp\objidpoolmanager::returnobjectiveid(self.minimapid);
    self.minimapid = undefined;
  }

  if(isDefined(self.helperdronetype) && (self.helperdronetype == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC" || self.helperdronetype == "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B")) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_8AA50991E565083EF82F9D"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_8AA50991E565083EF82F9D")]](self, 1);

    helperdrone_returnplayer(self.owner);
  }

  if(istrue(var_1)) {
    if(isDefined(self.owner))
      self.owner playlocalsound("_encstr_88B71BBB592C0EF56CD019AC470E2C365BFAD193A5B3ECB29CF51C63E4");

    spawn_ai_solo();
  } else
    spawn_aitype();

  scripts\cp_mp\emp_debuff::allow_emp(0);
  self notify("_encstr_860808CB78E2984063BA");

  if(isDefined(self.streakinfo.superid)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8"))
      self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_A18C12DEE6325A59B18C550EB393B032598ACDC8")]]("_encstr_955F12039B0FAFA2B9AD353BBF18A113B6704AEA", self.usedcount);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8A6705191B7B76", "_encstr_8703140952578998E3C06745F997A8D58B5B60737A8B"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8A6705191B7B76", "_encstr_8703140952578998E3C06745F997A8D58B5B60737A8B")]](self.owner, self.streakinfo.superid, self.usedcount, istrue(var_0));
  }

  waitframe();
  var_3 = self.owner;
  removehelperdrone(self.helperdronetype, level.helperdronesettings[self.helperdronetype], var_0);

  if(level.gametype != "_encstr_B607038AAB" && isDefined(var_3) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B607038AAB", "_encstr_AB0F11DCBAE02B274D8DB78E6863ACC237AA0E"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B607038AAB", "_encstr_AB0F11DCBAE02B274D8DB78E6863ACC237AA0E")]](var_3);
}

spawn_aitype() {
  var_0 = level.helperdronesettings[self.helperdronetype];

  if(isDefined(var_0.fxid_explode))
    playFX(var_0.fxid_explode, self.origin);

  if(isDefined(var_0.sound_explode))
    self playSound(var_0.sound_explode);
}

spawn_ai_solo() {
  var_0 = level.helperdronesettings[self.helperdronetype];
  self setscriptablepartstate("_encstr_860808CB78E2984063BA", "_encstr_BDE80911CA4B20E0D6FC4B");
  var_1 = scripts\common\utility::playersinsphere(self.origin, 2000);

  foreach(var_3 in var_1) {
    if(!isDefined(var_3) || !var_3 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(isDefined(self.owner) && var_3 == self.owner) {
      continue;
    }
    var_3 earthquakeforplayer(0.3, 2, var_3.origin, 100);
    var_3 setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
    var_3 playrumbleonpositionforclient("_encstr_97B91727302BC16A69052298603DB39DB1688F57586007F261", var_3.origin);
  }

  if(isDefined(self.owner)) {
    self.owner earthquakeforplayer(0.2, 2, self.owner.origin, 100);
    self.owner setclientomnvar("_encstr_BA2A0D5D4BD743AE32EB6E340BB559", 1);
    self.owner playrumbleonpositionforclient("_encstr_97B91727302BC16A69052298603DB39DB1688F57586007F261", self.owner.origin);
  }
}

removehelperdrone(var_0, var_1, var_2) {
  helperdrone_disableradar();

  if(isDefined(self.useobj))
    self.useobj delete();

  if(isDefined(self.playersfx))
    self.playersfx delete();

  if(isDefined(self.scrambler))
    self.scrambler delete();

  if(isDefined(self.enemyobjid))
    scripts\mp\objidpoolmanager::returnobjectiveid(self.enemyobjid);

  if(isDefined(self.pulsedarts) && self.pulsedarts.size > 0) {
    foreach(var_4 in self.pulsedarts)
    var_4 notify("_encstr_AD75063D571AE108");
  }

  if(!istrue(self.streakinfo.issuper)) {
    if(isDefined(level.killstreakfinishusefunc))
      level thread[[level.killstreakfinishusefunc]](self.streakinfo);
  }

  if(isDefined(self.owner)) {
    if(isDefined(self.owner.helperdrone))
      self.owner.helperdrone = undefined;

    self.owner clearsoundsubmix("_encstr_954E0F02DB781387F8379EA7C998CD9B9D", 1);
    self.owner notify("_encstr_BD4411B2E6EC7D8CE4F6DC2B7D5DC132161DB2", -1);

    if(var_0 == "_encstr_81E01312A3403EA3C0F95B724025DFF7200FB79A11" || var_0 == "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_9AE10CA1DBF963911A20E839FB60"))
        self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_9AE10CA1DBF963911A20E839FB60")]]();
    }

    self.streakinfo.onspray = istrue(var_2);
    self.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7(self.streakinfo);
  }

  if(var_0 == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD")
    scramblerdrone_counteruavmodeoff();

  if(istrue(self.nonvehicle))
    self delete();
  else
    scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB")
    self.owner setclientomnvar("_encstr_B42D181FA4C122A3EC31C0BB932B52E26F3B600BD68C2B3F4738", 0);
}

helperdrone_returnplayer(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  var_1 = self.helperdronetype;
  var_2 = level.helperdronesettings[var_1];

  if(isDefined(self.targetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.targetmarkergroup);
    self.targetmarkergroup = undefined;
  }

  self.ispiloted = undefined;

  if(isDefined(self.enemiesmarked)) {
    foreach(var_4 in self.enemiesmarked)
    markupdateheadicon(var_4, var_0);
  }

  var_0 thread recondrone_takedeployweapon(!isalive(var_0), 1);
  var_0 helperdrone_takeplayerfauxremote(self.streakinfo);
  var_0 painvisionon();
  var_0 scripts\common\utility::allow_usability(1);
  var_0 scripts\common\utility::allow_fire(1);
  var_0 thread soundorg_int();
  var_0 cameraunlink(self);
  var_0 remotecontrolvehicleoff();
  scripts\cp_mp\utility\killstreak_utility::_id_11DC1(var_0);

  if(isDefined(var_0.restoreangles)) {
    var_0 setplayerangles((var_0.restoreangles[0], var_0.restoreangles[1], 0));
    var_0.restoreangles = undefined;
  }

  var_0 scripts\cp_mp\utility\killstreak_utility::killstreak_restorenvgstate();
}

soundorg_int() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 = gettime();
  var_1 = 1000;

  while(gettime() - var_0 < var_1) {
    _id_131B7(0);
    waitframe();
  }
}

exceededmaxhelperdrones(var_0, var_1) {
  if(!isDefined(level.supportdrones))
    return 0;

  if(level.incominghelperdrones.size > 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")) {
      if(level.incominghelperdrones.size >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")]]())
        return 1;
    }

    foreach(var_3 in level.incominghelperdrones) {
      if(isDefined(var_3.owner) && var_3.owner == var_1) {
        continue;
      }
      if(var_0.streakname == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC" && var_3.type == var_0.streakname) {
        if(level.teambased) {
          if(isDefined(var_3.owner) && isDefined(var_3.owner.team) && var_3.owner.team == var_1.team)
            return 1;
        }
      } else if(var_0.streakname == "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B" && var_3.type == var_0.streakname) {
        if(level.teambased) {
          if(isDefined(var_3.owner) && isDefined(var_3.owner.team) && var_3.owner.team == var_1.team)
            return 1;
        }
      } else if(var_0.streakname == "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60" && var_3.type == var_0.streakname) {
        if(level.teambased) {
          if(helperdrone_getnumdrones("_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60", level.incominghelperdrones, var_1.team) >= 10)
            return 1;
        }

        if(helperdrone_getnumdrones("_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60", level.incominghelperdrones) >= 20)
          return 1;
      } else if(var_0.streakname == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD" && var_3.type == var_0.streakname) {
        if(level.teambased) {
          if(helperdrone_getnumdrones("_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD", level.incominghelperdrones, var_1.team) >= 10)
            return 1;
        }
      }
    }
  }

  if(level.supportdrones.size > 0) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")) {
      if(level.supportdrones.size >= [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_96FD13ABF7F35C50E8DCE118C7DBB9890A6707339B")]]())
        return 1;
    }

    foreach(var_3 in level.supportdrones) {
      if(var_0.streakname == "_encstr_81E01312A3403EA3C0F95B724025DFF7200FB79A11" && var_3.helperdronetype == var_0.streakname) {
        if(isDefined(var_3.owner) && var_3.owner == var_1) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
            var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_ABAA2584F3C19833EFF9677FD9E7B7902F19DA8EC893E066D6595BCBB19D9479B78550342E01F9");

          return 1;
        }
      } else if(var_0.streakname == "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC" && var_3.helperdronetype == var_0.streakname) {
        if(level.teambased) {
          if(var_3.team == var_1.team) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
              var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");

            return 1;
          }
        }
      } else if(var_0.streakname == "_encstr_8C950E2F42AB5B3BFC5B7958BB07909B" && var_3.helperdronetype == var_0.streakname) {
        if(level.teambased) {
          if(var_3.team == var_1.team) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
              var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");

            return 1;
          }
        }
      } else if(var_0.streakname == "_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60" && var_3.helperdronetype == var_0.streakname) {
        if(helperdrone_getnumdrones("_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60", level.supportdrones) >= 20) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
            var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_819B225BAB843BD2A969A0F8B97F05C79C8EC7DB5F4D5F6F97B1081031370247B71D6544");

          return 1;
        }

        if(level.teambased) {
          if(helperdrone_getnumdrones("_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60", level.supportdrones, var_1.team) >= 10) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
              var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_848D2823FB097D3F5D37D098FC3616E5C961BFB6A55977036DECE961A765AB2A61A5193427298E138707");

            return 1;
          }
        }

        if(helperdrone_getnumdrones("_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60", level.supportdrones, var_1) >= 1) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
            var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_81662A8478DBC179CB8A5B4B8B62D2B787A11F8CB04709E192B15143FA5979717348D55529E7D7493B414D33");

          return 1;
        }
      } else if(var_0.streakname == "_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD" && var_3.helperdronetype == var_0.streakname) {
        if(level.teambased) {
          if(helperdrone_getnumdrones("_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD", level.supportdrones, var_1.team) >= 10) {
            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
              var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_9B53257BA3512577150F184034CECE2D8129F7FE6D91BF3B35A4D1A91D28FF55418B721FCB8933");

            return 1;
          }
        } else if(helperdrone_getnumdrones("_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD", level.supportdrones, var_1) >= 2) {
          if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
            var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_9B53257BA3512577150F184034CECE2D8129F7FE6D91BF3B35A4D1A91D28FF55418B721FCB8933");

          return 1;
        }
      }
    }
  }

  return 0;
}

helperdrone_getnumdrones(var_0, var_1, var_2) {
  var_3 = 0;

  foreach(var_5 in var_1) {
    if(isDefined(var_5.type) && var_5.type == var_0 || isDefined(var_5.helperdronetype) && var_5.helperdronetype == var_0) {
      if(isDefined(var_2)) {
        if(isPlayer(var_2)) {
          if(var_5.owner != var_2)
            continue;
        } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_AA040F90179FF90B9ADA8907F0E153A1ED") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_AA040F90179FF90B9ADA8907F0E153A1ED")]](var_2)) {
          if(var_5.team != var_2)
            continue;
        }
      }

      var_3++;
    }
  }

  return var_3;
}

helperdrone_destroyongameend() {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  level scripts\engine\utility::_id_143A6("_encstr_935E0F139CF6D76E1A7B3AEB6E1D85E4D1", "_encstr_9B1D0BC7932875276230426AA1", "_encstr_B48B10CF58B0F96A343FB7E78BE502262081");
  helperdronedestroyed();
}

spawn_ai_and_seat_in_vehicle(var_0) {
  self endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_BA2D081B2B58B32D37EC");
  self endon("_encstr_860808CB78E2984063BA");
  var_1 = getdvarfloat("_encstr_91B31B7EAB19928A660F73BF7B99E3F128D37707A61046734D316F7B6B", 1500);
  var_2 = getdvarfloat("_encstr_8BE517151B21EEF0833D201EA664B0AB6BEF8193170B3F30D6", 5600);
  var_3 = var_1 + var_2;
  var_4 = 0.0;
  var_5 = 0.0;

  for(;;) {
    if(self.origin[2] > var_2) {
      if(self.origin[2] > var_3) {
        var_0 setclientomnvar("_encstr_9B9110AE2DF57BABD1F5DE997DC90BCDECB2", 0.0);
        helperdronedestroyed();
      }

      var_4 = (self.origin[2] - var_2) / var_1;
    } else
      var_4 = 0.0;

    if(var_4 != var_5) {
      var_5 = var_4;
      var_0 setclientomnvar("_encstr_9B9110AE2DF57BABD1F5DE997DC90BCDECB2", var_4);
    }

    waitframe();
  }
}

helperdrone_gettargetoffset(var_0, var_1) {
  var_2 = level.helperdronesettings[var_0.helperdronetype];
  var_3 = var_2.backoffset;
  var_4 = var_2.sideoffset;
  var_5 = var_0 helperdrone_getheightoffset(var_2);

  if(isDefined(var_0.low_entry))
    var_5 = var_5 * var_0.low_entry;

  var_6 = (var_4, var_3, var_5);
  return var_6;
}

helperdrone_istargetinreticle(var_0, var_1, var_2) {
  var_3 = 0;
  var_4 = var_0.origin;

  if(isDefined(var_0._id_12A9C))
    var_4 = var_4 + var_0._id_12A9C;

  var_5 = [var_4];

  if(isPlayer(var_0)) {
    var_6 = var_0 scripts\mp\utility\player::round_smoke_logic();
    var_7 = var_0 scripts\mp\utility\player::getstancecenter();
    var_5 = [var_6, var_7, var_4];
  } else if(isagent(var_0))
    var_5 = [var_4 + (0, 0, 1)];

  foreach(var_9 in var_5) {
    if(self worldpointinreticle_circle(var_9, var_1, var_2)) {
      var_3 = 1;
      break;
    }
  }

  return var_3;
}

find_safe_spawn(var_0) {
  var_1 = self.angles;
  var_2 = (0, 0, 80);
  var_3 = level.helperdronesettings[var_0].spawndist;
  var_4 = (0, 0, var_2[2]);
  var_5 = level.helperdronesettings[var_0].halfsize;
  var_6 = anglesToForward(self.angles);
  var_7 = anglestoright(self.angles);
  var_8 = self.origin + (0, 0, 30);
  var_9 = var_3 + 20;

  if(self getstance() == "_encstr_922406F1A6FD5E05")
    var_9 = var_9 + 25;

  if(_calloutmarkerping_handleluinotify_enemyrepinged::_id_124F5())
    var_4 = var_4 + (0, 0, 130);

  var_10 = [var_4 + var_3 * var_6, var_4 - var_3 * var_6, var_4 + var_3 * var_7, var_4 - var_3 * var_7, var_4, var_4 + 0.707 * var_3 * (var_6 + var_7), var_4 + 0.707 * var_3 * (var_6 - var_7), var_4 + 0.707 * var_3 * (var_7 - var_6), var_4 + 0.707 * var_3 * (-1 * var_6 - var_7), var_9 * var_6, -1 * var_9 * var_6, var_9 * var_7, -1 * var_9 * var_7, (0, 0, 0), 0.707 * var_9 * (var_6 + var_7), 0.707 * var_9 * (var_6 - var_7), 0.707 * var_9 * (var_7 - var_6), 0.707 * var_9 * (-1 * var_6 - var_7)];
  var_11 = 0;

  for(var_12 = 0; var_12 < var_10.size; var_12++) {
    if(4 <= var_11) {
      var_11 = 0;
      wait 0.05;
    }

    var_13 = var_10[var_12];
    var_14 = var_8 + var_13;
    var_15 = vectorNormalize(var_13) * 50;
    var_16 = var_8 + var_15;
    var_17 = physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_8DDD1C83862FCDA5D8DCD8ED371DCA73D16EAFB3AC34B46C8DB26C8D2D07", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4"]);
    var_18 = scripts\engine\trace::ray_trace(var_8, var_16, self, var_17);

    if(var_18["_encstr_AA1C0886968EA32FE056"] != "_encstr_AC4B0D3BD013D433491D6125700D8A") {
      continue;
    }
    var_19 = scripts\engine\trace::sphere_trace(var_16, var_14, var_5, self, var_17);
    var_20 = var_19["_encstr_A53009A25003666B9818C6"];
    var_21 = var_20 * (var_14 - var_16);
    var_22 = var_16 + var_21;

    if(var_20 > 0) {
      self.recondronesafespawn = var_22;
      return var_22;
    }

    var_11++;
  }

  return undefined;
}

helperdrone_giveplayerfauxremote(var_0) {
  self endon("_encstr_B6AA0C192DB9C67BE637958D1D01");
  scripts\cp_mp\utility\player_utility::setusingremote(var_0.streakname);
  scripts\common\utility::allow_weapon_switch(0);
}

helperdrone_takeplayerfauxremote(var_0) {
  scripts\cp_mp\utility\player_utility::clearusingremote(1);
  scripts\common\utility::allow_weapon_switch(1);
  scripts\common\utility::allow_offhand_weapons(1);
  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
  var_1 = getcompleteweaponname("_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E");

  if(self hasweapon(var_1))
    thread scripts\cp_mp\utility\inventory_utility::getridofweapon(var_1);
}

helperdrone_showminimaponspawn(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_860808CB78E2984063BA");
  var_0 endon("_encstr_BA2D081B2B58B32D37EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = self.guid;
  level notify("_encstr_8CE11A34814858722691DBB7DD45199390286B7138C81ECAF1F3DB7F" + var_1);
  level endon("_encstr_8CE11A34814858722691DBB7DD45199390286B7138C81ECAF1F3DB7F" + var_1);

  if(istrue(level.istacops)) {
    return;
  }
  for(;;) {
    self waittill("_encstr_A76F0F9B1C16BB37B246FAC1C616E59527");

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8FD40CAAA82AAF81A033D9C40B43")]]();

    self.showuavminimaponspawn = 1;
  }
}

recondrone_beginsuper() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9196100D8D3E98E8CBF32008EAA790B8D7E4");
  self endon("_encstr_9969107307C2C01041C528880BE9703B35B3");
  var_0 = spawnStruct();
  var_0.streakname = "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC";
  var_0.weaponname = "_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E";
  var_0.issuper = 1;
  var_0.superid = level.superglobals.staticsuperdata["_encstr_955F12039B0FAFA2B9AD353BBF18A113B6704AEA"].id;

  if(!tryusehelperdroneearlyout(var_0, 1)) {
    self.recondronereserved = 1;
    thread recondrone_watchcleanupreserved(var_0, 0);

    if(scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
      self.reconvehiclereserved = 1;
      thread recondrone_watchcleanupreserved(var_0, 1);

      if(recondrone_givedeployweapon()) {
        thread recondrone_watchsuper(var_0);
        return 1;
      } else {
        thread recondrone_takedeployweapon(undefined, 1);
        thread recondrone_cleanupreserved(var_0, 1);
      }
    } else
      thread recondrone_cleanupreserved(var_0, 0);
  }

  return 0;
}

recondrone_endsuper(var_0) {
  self notify("_encstr_9196100D8D3E98E8CBF32008EAA790B8D7E4");
  self.recondronesafespawn = undefined;

  if(isDefined(self.recondronerefund)) {
    self.recondronerefund = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2") && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_BD9E15AF55CB1EB3C3D5D017DF80C8F036807FED08DF04"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_86D01020A8A31A27783BBDB2F1E7BB852CE2")]]([[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_BD9E15AF55CB1EB3C3D5D017DF80C8F036807FED08DF04")]]());
  }

  if(isDefined(self.recondronereserved)) {
    self.recondronereserved = undefined;
    var_1 = spawnStruct();
    var_1.streakname = "_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC";
    recondrone_cleanupreserved(var_1);
  }

  if(isDefined(self.reconvehiclereserved)) {
    self.reconvehiclereserved = undefined;
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
  }
}

recondrone_watchsuper(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_1 = _id_12A98(var_0);

  if(!isDefined(var_1))
    thread recondrone_takedeployweapon(!isalive(self), 1);
  else if(!var_1) {
    thread recondrone_takedeployweapon(!isalive(self), 1);

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9")]](1);
  } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9")]](0);
}

_id_12A98(var_0) {
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_9196100D8D3E98E8CBF32008EAA790B8D7E4");
  self endon("_encstr_9969107307C2C01041C528880BE9703B35B3");
  thread recondrone_watchsuperendfromswitch();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_86E50C038828D8FA5595221DF813", "_encstr_A34D19707AD3258855E6099D1FFD70E69733895B31236F58ABC541"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_86E50C038828D8FA5595221DF813", "_encstr_A34D19707AD3258855E6099D1FFD70E69733895B31236F58ABC541")]]();

  thread recondrone_disablecontrols(2.15);
  wait 1.85;
  childthread find_safe_spawn(var_0.streakname);
  wait 0.15;

  if(level.gameended)
    self.recondronesafespawn = undefined;

  var_1 = 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_87850E106B0CBDECEF034DD6FC175061"))
    var_1 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_87850E106B0CBDECEF034DD6FC175061")]](self);

  if(isDefined(self.recondronesafespawn) && !var_1) {
    self.reconvehiclereserved = undefined;
    thread recondrone_watchcleanupreserved(var_0, 0);
    var_2 = createhelperdrone(self.recondronesafespawn, self.angles, var_0.streakname, var_0, 0, 1);
    self.recondronesafespawn = undefined;

    if(isDefined(var_2)) {
      thread helperdrone_giveplayerfauxremote(var_0);
      var_2 recondrone_addtolists(var_2, self);
      thread starthelperdrone(var_2);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361"))
        level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8260069BDBBACD46", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361")]](self, "_encstr_A9A510B56387FEFD47125040C95FB5B0D31D");

      var_3 = scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_9B420C2F7F737FA9ED421DB920FB")]]() == "_encstr_B607038AAB";

      if(var_3)
        var_2 vehicleshowonminimap(0);

      return 1;
    } else
      helperdronecreationfailedfx(var_0.streakname);
  } else
    helperdronecreationfailedfx(var_0.streakname);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]]("_encstr_BE361D694AC4269A8A94A2145A35E5C99EA2EB1527D355E884F56A41281A51");

  if(istrue(self.inlaststand) && isDefined(self.super)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEB406F03B72BB3B", "_encstr_83FC17704FBCA91189EB971502504B13042FF0488B44A525A2"))
      self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEB406F03B72BB3B", "_encstr_83FC17704FBCA91189EB971502504B13042FF0488B44A525A2")]](self.super.staticdata.weapon);
  }

  return 0;
}

recondrone_disablecontrols(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(istrue(level.mine_caves_turrets))
    self freezecontrols(1);
  else
    scripts\cp_mp\utility\player_utility::_freezecontrols(1, undefined, "_encstr_AD050BE42B1BBDCD889CDB37CA");

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  if(istrue(level.mine_caves_turrets))
    self freezecontrols(0);
  else
    scripts\cp_mp\utility\player_utility::_freezecontrols(0, undefined, "_encstr_AD050BE42B1BBDCD889CDB37CA");
}

recondrone_watchsuperendfromswitch() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9196100D8D3E98E8CBF32008EAA790B8D7E4");
  self endon("_encstr_9969107307C2C01041C528880BE9703B35B3");
  self endon("_encstr_8536230D7FDA5880BC62E8C04F7F908703DFB1D757931528957D71DDB22708D6EB1F313FBB");
  var_0 = getcompleteweaponname("_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E");

  for(;;) {
    if(self getcurrentweapon() != var_0) {
      break;
    }

    waitframe();
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BEF4071AA87BDF5220", "_encstr_ABA011C3FB6B1530CBEB5B05E9ED20E6F312B9")]](1);
}

recondrone_unsetsuper(var_0) {
  self notify("_encstr_9969107307C2C01041C528880BE9703B35B3");

  if(0) {
    var_1 = self.recondronesuper;

    if(isDefined(var_1)) {
      if(!istrue(var_1.isdestroyed))
        var_1 helperdronedestroyed();
    }
  }

  thread recondrone_endsuper(var_0);
}

recondrone_givedeployweapon() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_B193169C958DF69B11C9DE9B597595851CB7E65158AD9537");
  self notify("_encstr_91BE1639CAD8BD37449CB7B959AECAC20EB7CD1D5AB3CA37");
  self endon("_encstr_91BE1639CAD8BD37449CB7B959AECAC20EB7CD1D5AB3CA37");
  var_0 = getcompleteweaponname("_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E");

  if(!self hasweapon(var_0))
    scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);

  recondrone_allowcontrols(0);
  var_1 = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_0, 1);
  return var_1;
}

recondrone_takedeployweapon(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_91BE1639CAD8BD37449CB7B959AECAC20EB7CD1D5AB3CA37");
  self notify("_encstr_B193169C958DF69B11C9DE9B597595851CB7E65158AD9537");
  self endon("_encstr_B193169C958DF69B11C9DE9B597595851CB7E65158AD9537");
  var_2 = getcompleteweaponname("_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E");

  if(istrue(var_1)) {
    if(scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_2)) {
      scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(var_2);
      return;
    }
  }

  recondrone_allowcontrols(1, var_0);

  if(istrue(var_1))
    scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2);
}

recondrone_allowcontrols(var_0, var_1) {
  var_1 = istrue(var_1);

  if(var_0) {
    if(!isDefined(self.recondronefrozecontrols)) {
      return;
    }
    if(!var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8F731006D0383723E08387EFE31FCA75707B"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8F731006D0383723E08387EFE31FCA75707B")]](var_0);

      scripts\common\utility::allow_usability(var_0);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_964E0DB08D63B7BB742BE61DD59C56"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_964E0DB08D63B7BB742BE61DD59C56")]](var_0);
    }

    self.recondronefrozecontrols = undefined;
  } else {
    if(isDefined(self.recondronefrozecontrols)) {
      return;
    }
    if(!var_1) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8F731006D0383723E08387EFE31FCA75707B"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_BE8F0A272F9B2BE97268AE8B", "_encstr_8F731006D0383723E08387EFE31FCA75707B")]](var_0);

      scripts\common\utility::allow_usability(var_0);

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_964E0DB08D63B7BB742BE61DD59C56"))
        self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_964E0DB08D63B7BB742BE61DD59C56")]](var_0);
    }

    self.recondronefrozecontrols = 1;
  }
}

recondrone_watchcleanupreserved(var_0, var_1) {
  self notify("_encstr_BDFE1B06670AE7F874E3586887579129B28EF00DBAB14B033D8B98386B");
  self endon("_encstr_BDFE1B06670AE7F874E3586887579129B28EF00DBAB14B033D8B98386B");
  self waittill("_encstr_8D820B49520F0EC02DDE6367EC");
  thread recondrone_cleanupreserved(var_0, var_1);
}

recondrone_cleanupreserved(var_0, var_1) {
  self notify("_encstr_BDFE1B06670AE7F874E3586887579129B28EF00DBAB14B033D8B98386B");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]](1);

  removeincominghelperdrone(var_0);

  if(istrue(var_1))
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
}

recondrone_addtolists(var_0, var_1) {
  var_1.recondronesuper = var_0;
  var_1.pausesuperpointsovertime = 1;
  var_2 = var_0 getentitynumber();

  if(!isDefined(level.recondronesupers))
    level.recondronesupers = [];

  level.recondronesupers[var_2] = var_0;
  thread recondrone_removefromlistsondeath(var_0, var_1, var_2);
}

recondrone_removefromlists(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 notify("_encstr_8D3C1B06670AE7F874E358688757B33B320DFC0537B35FC014E7B0B037");
    var_2 = var_0 getentitynumber();
  }

  if(isDefined(var_1)) {
    var_1.recondronesuper = undefined;
    var_1.pausesuperpointsovertime = 0;
  }

  if(isDefined(level.recondronesupers))
    level.recondronesupers[var_2] = undefined;
}

recondrone_removefromlistsondeath(var_0, var_1, var_2) {
  var_0 endon("_encstr_8D3C1B06670AE7F874E358688757B33B320DFC0537B35FC014E7B0B037");
  var_0 waittill("_encstr_AD75063D571AE108");
  thread recondrone_removefromlists(var_0, var_1, var_2);
}

deliverydrone_delivertopoint(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9196100D8D3E98E8CBF32008EAA790B8D7E4");
  self endon("_encstr_9969107307C2C01041C528880BE9703B35B3");
  var_2 = spawnStruct();
  var_2.streakname = "_encstr_BEA30A38875DC0976282A037";
  var_2.issuper = 1;

  if(tryusehelperdroneearlyout(var_2, 1)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A"))
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_9A50080BA7292FFA0DA2", "_encstr_995B1A232B3627CAB5CA9BA31985AE0F5995D0D2D81BACA1B7BAE63A")]]();

    removeincominghelperdrone(var_2);
    return undefined;
  }

  var_3 = var_0 + (0, 0, 4000) - anglesToForward(self.angles) * 0;
  var_4 = createhelperdrone(var_3, self.angles, var_2.streakname, var_2);

  if(!isDefined(var_4))
    return undefined;

  removeincominghelperdrone(var_2);
  var_4.deliverytarget = var_0;
  var_4.ondelivercallback = var_1;
  thread starthelperdrone(var_4);
  return var_4;
}

scramblerdrone_counteruavmodeon() {
  scripts\cp_mp\killstreaks\uav::addactivecounteruav();
  level notify("_encstr_8B540B6DB903360BFAAAF85852");
}

scramblerdrone_counteruavmodeoff() {
  scripts\cp_mp\killstreaks\uav::removeactivecounteruav();
  level notify("_encstr_8B540B6DB903360BFAAAF85852");
}

monitoroutofboundsdistortion() {
  self.owner endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_AD75063D571AE108");
  var_0 = 0.0;

  for(;;) {
    if(isDefined(level.outofboundstriggers)) {
      var_1 = 0;

      foreach(var_3 in level.outofboundstriggers) {
        if(!isDefined(var_3)) {
          continue;
        }
        if(var_3.classname == "_encstr_956B0F193B6244C0659AE65B464C78857B") {
          continue;
        }
        if(self istouching(var_3)) {
          var_1 = 1;
          break;
        }
      }

      if(var_1)
        var_0 = var_0 + 1.0 * level.framedurationseconds;
      else
        var_0 = var_0 - 2.0 * level.framedurationseconds;

      var_0 = clamp(var_0, 0.0, 0.5);
      self.owner setclientomnvar("_encstr_9B9110AE2DF57BABD1F5DE997DC90BCDECB2", var_0);
    }

    waitframe();
  }
}

istargetmarked() {
  if(isDefined(level.supportdrones) && level.supportdrones.size > 0) {
    foreach(var_1 in level.supportdrones) {
      if(istrue(scripts\cp_mp\utility\player_utility::playersareenemies(self, var_1.owner))) {
        if(isDefined(var_1.enemiesmarked) && isDefined(var_1.enemiesmarked[self getentitynumber()]))
          return 1;
      }
    }
  }

  return 0;
}

unset_relic_noks() {
  if(isDefined(level.helperdronesettings)) {
    if(isDefined(self.streakinfo))
      return scripts\engine\utility::array_contains_key(level.helperdronesettings, self.streakinfo.streakname);
  }

  return 0;
}