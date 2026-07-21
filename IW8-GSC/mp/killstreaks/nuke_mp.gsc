/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\nuke_mp.gsc
***********************************************/

_id_13FD1() {
  var_0 = getDvar("_encstr_8B6210CD3639FADADE9D952B56D0A5B1C6AC", "_encstr_B40101");

  if(var_0 != "_encstr_B40101") {
    var_1 = scripts\mp\gamelogic::gethostplayer();

    if(isDefined(var_1))
      var_1 thread level_death_notify(var_0);
  }

  var_2 = getDvar("_encstr_87F513802A829F2B9B51378D0BEF9081EA92D8C083", "_encstr_B40101");

  if(var_2 != "_encstr_B40101") {
    var_1 = scripts\mp\gamelogic::gethostplayer();

    if(isDefined(var_1))
      var_1 thread _id_123AA(var_2);
  }

  var_3 = getDvar("_encstr_998C1368C26A4771CB6737364F9F798BD2781010AA", "_encstr_B40101");

  if(var_3 != "_encstr_B40101") {
    var_1 = scripts\mp\gamelogic::gethostplayer();

    if(isDefined(var_1))
      var_1 thread minplunderdropondeath(var_3);
  }

  var_4 = getDvar("_encstr_828916DC1B39D7165A39E063B073CAA057E8DB3543BDF63A", "_encstr_B40101");

  if(var_4 != "_encstr_B40101") {
    var_1 = scripts\mp\gamelogic::gethostplayer();

    if(isDefined(var_1))
      var_1 thread br_laststandfinishplayerisincapacitated(var_4);
  }

  var_5 = getDvar("_encstr_8EE90B83DA23487083B65D6184", "_encstr_B40101");

  if(var_5 != "_encstr_B40101")
    level thread _encstr_8E931D26EBE6B4C3BBA34F6B727E29FF2BCA556A5B776F6E34A9BBD017C84F::left_side_spawn_adjuster(var_5);
}

level_death_notify(var_0) {
  var_1 = self;
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!isDefined(var_0))
    iprintlnbold("_encstr_84373A0AB9408FEAFE092F6BE92962FE5086C31730607BC25D997B3F5B456B602801FA9EEB880D6A2D3B031A39EDA399A09375674ADACF5388E36B0B");

  var_2 = var_1.origin;
  var_3 = var_1 getplayerangles();
  var_4 = anglesToForward(var_3);
  var_5 = (var_2[0], var_2[1], var_2[2] + var_1 getplayerviewheight());
  var_6 = var_5 + var_4 * 5000;
  var_7 = scripts\engine\trace::create_default_contents(0);
  var_8 = scripts\engine\trace::ray_trace(var_5, var_6, var_1, var_7);

  switch (var_0) {
    case "_encstr_9719046F33E3":
      var_9 = (0, 0, 200);
      break;
    case "_encstr_AD2307ECC9EDABDC32":
      var_9 = (0, 0, 0);
      break;
    default:
      iprintlnbold("_encstr_95551F2BFE4BB941C4E2AAD84A5B1B36339D33A34B8BE1216A9A30B002B7E1898B");
      return;
  }

  var_10 = var_8["_encstr_850E077B0BF30318B9"];

  if(!isDefined(var_10)) {
    var_11 = undefined;
    var_12 = 9000;

    foreach(var_14 in level.vehicle.instances) {
      foreach(var_10 in var_14) {
        var_16 = distance(var_10.origin, var_1.origin);

        if(var_16 == 0.0 || var_16 < var_12) {
          var_12 = var_16;
          var_11 = var_10;
        }
      }
    }

    var_10 = var_11;

    if(!isDefined(var_10)) {
      iprintlnbold("_encstr_BDE924546A1AAC9895E14939063F18FBCFF28911434FCFA06DD643312F66B817733A03402AF2");
      return;
    }
  }

  var_19 = var_10.origin;
  var_20 = var_10.angles;
  var_21 = 10;
  var_22 = 0;

  if(!isDefined(var_10)) {
    return;
  }
  iprintlnbold("_encstr_868C2091B74830DFD25717592D8B3318AF3A89B0030D89253E75B8CC842267893F6B");
  wait 1;

  if(var_10 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_10.origin = var_10.origin + var_9;
    var_10 vehicle_turnengineon();
    var_10 vehicle_setspeed(10, 1, 1);

    while(var_22 < var_21) {
      var_22++;
      wait 1;

      if(!isDefined(var_10))
        return;
    }

    var_10 vehicle_setspeed(0, 0, 20);
    var_10 vehicle_turnengineoff();
    wait 0.3;

    if(!isDefined(var_10)) {
      return;
    }
    var_10.origin = var_19;
    var_10.angles = var_20;
  }
}

_id_123AA(var_0) {
  var_1 = self;
  var_2 = var_1.origin;
  var_3 = var_1 getplayerangles();
  var_4 = anglesToForward(var_3);
  var_5 = (var_2[0], var_2[1], var_2[2] + var_1 getplayerviewheight());
  var_6 = var_5 + var_4 * 5000;
  var_7 = scripts\engine\trace::create_default_contents(0);
  var_8 = scripts\engine\trace::ray_trace(var_5, var_6, var_1, var_7);
  var_9 = var_8["_encstr_850E077B0BF30318B9"];
  var_10 = scripts\engine\utility::array_combine(level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"], level.vehicle.instances["_encstr_83F40783ADF1D14AA3"]);

  if(!isDefined(var_9)) {
    var_11 = undefined;
    var_12 = 9000;

    foreach(var_9 in var_10) {
      var_14 = distance(var_9.origin, var_1.origin);

      if(var_14 == 0.0 || var_14 < var_12) {
        var_12 = var_14;
        var_11 = var_9;
      }
    }

    var_9 = var_11;

    if(!isDefined(var_9)) {
      iprintlnbold("_encstr_BDE924546A1AAC9895E14939063F18FBCFF28911434FCFA06DD643312F66B817733A03402AF2");
      return;
    }
  }

  if(!isDefined(var_9 getscriptablepartstate("_encstr_840703F23B", 1)))
    iprintlnbold("_encstr_88AF30517788F01F1297D78D6DFA4791E6C7C85AEB59EBDBFE7FF3A742B28D6040C3F8C003F569A93262EDBF5A1BF38BBD12");
  else {
    if(!isDefined(var_9.hours))
      var_9.hours = 0;

    if(var_9.hours) {
      iprintlnbold("_encstr_86E71BE3C089C6FAF195E75E751747D09570A3FBA86109B26F8F6557D4");
      var_9.hours = 0;
      var_9 setscriptablepartstate("_encstr_840703F23B", "_encstr_A29B05E9400E5D", 0);
      return;
    }

    var_9 notify("_encstr_BE92180BC15BD7AE184BD7F347D0B37377F822C3EE25BFA6F8A7");
    iprintlnbold("_encstr_A29A1AAF2807561AAEA552AA3BEA820A103F9D9BEB9AA054EF2AB870");
    var_9.hours = 1;
    var_9 setscriptablepartstate("_encstr_840703F23B", "_encstr_8B6007D127B04BD8E6", 0);
  }
}

minplunderdropondeath(var_0) {
  var_1 = self;
  var_2 = strtok(var_0, "_encstr_964C0249");
  var_3 = int(var_2[0]);
  var_4 = int(var_2[1]);
  var_5 = int(var_2[2]);

  if(!isDefined(var_3) || !isDefined(var_4) || !isDefined(var_5)) {
    iprintlnbold("_encstr_8C773A6CF08859F29BE1A293CFB1DAD040791AABE292F36BE5878F8B0BCF82C110E316B561C0E4A64B939797318D4E4088298CBB71D875EA10ADABCF");
    return;
  }

  var_6 = anglesToForward(var_1.angles);
  var_7 = var_1.origin + var_6 * var_3 + (0, 0, int(var_4));
  iprintlnbold("_encstr_924F208827F61C0409BDAD2602442B89EAB3740209DB6B2640B4378D7BADA59B7612");
  wait(var_5);
  _calloutmarkerping_handleluinotify_mappingdeletemarker::crushing_players(var_7);
}

br_laststandfinishplayerisincapacitated(var_0) {
  var_1 = self;
  var_2 = int(var_0);

  if(!isDefined(var_2)) {
    iprintlnbold("_encstr_99BC494B53C2C31DAFF23913038B874FB18F2034E6823862DB20FEA1EB48A753274895B2955D7BF09452874B8AB1B7C03850E558D04F90672A7BDC1A80620A03A8B77FBB51AF5A410B2FA2");
    return;
  }

  var_3 = var_1.origin;
  var_4 = var_1 getplayerangles();
  var_5 = anglesToForward(var_4);
  var_6 = (var_3[0], var_3[1], var_3[2] + var_1 getplayerviewheight());
  var_7 = var_6 + var_5 * 5000;
  var_8 = scripts\engine\trace::create_default_contents(0);
  var_9 = scripts\engine\trace::ray_trace(var_6, var_7, var_1, var_8);
  var_10 = var_9["_encstr_850E077B0BF30318B9"];
  var_11 = scripts\engine\utility::array_combine(level.vehicle.instances["_encstr_BDC80A5437EAD749519A6068"]);

  if(!isDefined(var_10)) {
    var_12 = undefined;
    var_13 = 9000;

    foreach(var_10 in var_11) {
      var_15 = distance(var_10.origin, var_1.origin);

      if(var_15 == 0.0 || var_15 < var_13) {
        var_13 = var_15;
        var_12 = var_10;
      }
    }

    var_10 = var_12;

    if(!isDefined(var_10)) {
      iprintlnbold("_encstr_BDE924546A1AAC9895E14939063F18FBCFF28911434FCFA06DD643312F66B817733A03402AF2");
      return;
    }
  }

  if(!isDefined(var_10)) {
    return;
  }
  if(istrue(var_10.turn_on_steam))
    var_10.turn_on_steam = 0;
  else {
    var_10.turn_on_steam = 1;
    var_10.isuseobject = var_10.origin;
    var_10.isteamvoplaying = var_10.origin + (0, 0, var_2);
  }

  var_17 = 0.2;

  if(isDefined(level.picking_up_minigun))
    var_17 = level.picking_up_minigun;

  if(var_10 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
    var_10.angles = (90, 0, 0);
    var_18 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_10, var_10._id_13E92);
    var_19 = 6;
    iprintlnbold("_encstr_BEEE22C841900537B7C7324A28F57F7DC8415445F5E88F826FFF2A3230CDB7B57029C7E6");

    for(;;) {
      if(isDefined(var_10.isteamvoplaying))
        var_10.origin = var_10.isteamvoplaying;

      var_18 shootturret("_encstr_A14F0AE336178944BA076F41", var_19);
      wait(var_17);

      if(!istrue(var_10.turn_on_steam)) {
        var_10.origin = var_10.isuseobject;
        var_10.angles = (0, 0, 0);
        iprintlnbold("_encstr_BAFC2341360B9B59019A347B7B4796DCD9022259985DEC1D106A1AF6BD1D5A9BEC08E96432");
        return;
      }
    }
  }
}