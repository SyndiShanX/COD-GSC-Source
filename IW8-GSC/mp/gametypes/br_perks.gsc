/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_perks.gsc
***********************************************/

init() {
  level.br_perk_points_enabled = getdvarint("_encstr_937313180FF296BD53B95FEDCAFAFF3B47BF785827", 0) != 0;

  if(!istrue(level.br_perk_points_enabled))
    return;
}

onplayerscore(var_0, var_1, var_2) {
  if(issubstr(var_0, "_encstr_ABD70578F3D02C") && istrue(level.br_perk_points_enabled)) {
    if(var_0 != "_encstr_92AE10AD275BC3CE4E047725C0377812A010") {
      if(isDefined(var_1) && isalive(var_1)) {
        if(var_1.br_perkpoints < var_2.br_perkpoints && var_1 scripts\mp\utility\perk::_hasperk("_encstr_ACA41AFB1B6BF9937ADB5C3B08BD6510F5FFD3A28BCB34DB9B9B7F06")) {
          var_1 giveperkpointstoplayer(var_1, var_2.br_perkpoints - var_1.br_perkpoints);
          var_1 scripts\mp\perks\perks::_unsetperk("_encstr_ACA41AFB1B6BF9937ADB5C3B08BD6510F5FFD3A28BCB34DB9B9B7F06");
          return;
        }

        var_1 iprintlnbold("_encstr_975B11FE43C93063531AC1B9C708D6ACBAF24E" + var_2.name + "_encstr_A90E08406DB4361B5632");
        var_1 perkpointsonkill(var_1);
      }
    }

    var_3 = scripts\mp\rank::getscoreinfovalue("_encstr_A68210DFBFAF8BEFB7C7E03172C73B106349");
    return var_3;
  }

  return 0;
}

perkpointsonkill(var_0) {
  var_1 = _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::round_enemy_stuck_logic(var_0.team, var_0.squadindex);

  foreach(var_0 in var_1)
  giveperkpointstoplayer(var_0, 1.0);
}

perkpointspercentageplayersalive() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level waittill("_encstr_9A040DC8621F5B8D5FC7A615D12BEA");
  wait 5;
  var_0 = level.maxplayercount;
  var_1 = 100.0 / var_0;
  var_2 = 5.0;

  for(;;) {
    wait(var_2);
    var_3 = scripts\mp\utility\game::getlivingplayers().size;
    var_4 = (var_0 - var_3) * var_1;

    if(!istrue(var_4 == 0)) {
      foreach(var_6 in level.players) {
        if(isalive(var_6))
          giveperkpointstoplayer(var_6, var_4);
      }
    }

    var_0 = var_3;
  }
}

takeperkpointpickup(var_0) {
  if(!istrue(level.br_perk_points_enabled)) {
    return;
  }
  var_1 = 1;

  if(isDefined(var_0.count))
    var_1 = var_0.count;

  if(var_0.scriptablename == "_encstr_A58612826B94B73D40E9E123061AE9B07B2B8BAB")
    perkpointspickup(self);
  else
    _encstr_8331245636CB3BEB9417AAA00397416342DF4DDB4A12D7F86A3B21400FF318B33BC2E86C62AA::trypickupitem(var_0.scriptablename, var_1);
}

perkpointspickup(var_0) {
  var_1 = getdvarint("_encstr_AB012043F642C9061B3FA99B93D2C0F8E7CC683B1A87684B2287ABB90FEB17A095A7", 5.0);
  giveperkpointstoplayer(var_0, var_1);
}

giveperkpointstoplayer(var_0, var_1) {
  var_0.br_perkpoints = clamp(var_0.br_perkpoints + var_1, 0, 150);

  if(var_0.br_perkpoints < 20)
    var_0.perklevel = 0;
  else if(var_0.br_perkpoints < 30)
    var_0.perklevel = 1;
  else if(var_0.br_perkpoints < 42)
    var_0.perklevel = 2;
  else if(var_0.br_perkpoints < 56)
    var_0.perklevel = 3;
  else if(var_0.br_perkpoints < 72)
    var_0.perklevel = 4;
  else if(var_0.br_perkpoints < 90)
    var_0.perklevel = 5;
  else if(var_0.br_perkpoints < 110)
    var_0.perklevel = 6;
  else if(var_0.br_perkpoints < 130)
    var_0.perklevel = 7;
  else if(var_0.br_perkpoints < 150)
    var_0.perklevel = 8;
}

buyperkinslot(var_0) {
  if(var_0 < self.br_perks.size) {
    var_1 = self.br_perks[var_0];

    if(var_1 < 3) {
      if(self.br_perkpoints < var_1 + 1)
        self iprintlnbold("_encstr_A50A1CACBD57086C16DC398E0458CC337B9323101D0D2DE6080E564EB690");
      else {
        self.br_perks[var_0]++;

        switch (var_0) {
          case 0:
            if(var_1 == 0) {
              scripts\mp\utility\perk::giveperk("_encstr_B4DB15D237DB22713140FBD7C148317BA1D85A8C15610A");
              thread scripts\mp\hud_message::showsplash("_encstr_A59F1826397D371CCA1BB458631D5EEB430B278CD7B934568D63");
            } else if(var_1 == 1)
              thread scripts\mp\hud_message::showsplash("_encstr_AA5117D28B81BBC7A82FABCA83A1B30708F4C2386730A97680");
            else if(var_1 == 2) {
              scripts\mp\utility\perk::giveperk("_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19");
              thread scripts\mp\hud_message::showsplash("_encstr_8A12190A5E8EAF429348DA5258D9786741C99193F5D30BCC4B0812");
            }

            break;
          case 1:
            if(var_1 == 0) {
              scripts\mp\utility\perk::giveperk("_encstr_99C916E638ACB1B42C8D47E5AF1B4B9D1AE8EE59D2B3D0E8");
              thread scripts\mp\hud_message::showsplash("_encstr_8A5119F1229F58FF9A5F0B235BB343F1747CD9484B1F503BD21B39");
            } else if(var_1 == 1) {
              scripts\mp\utility\perk::giveperk("_encstr_83121363D8BDF7A3B9CD7BDBC7D1398248FB828218");
              thread scripts\mp\hud_message::showsplash("_encstr_835816C4C9FA370EAC36A5851BE8CB7D5BB0E40B1D86DBCD");
            } else if(var_1 == 2) {
              scripts\mp\utility\perk::giveperk("_encstr_974F126E38591BB4C2B1D12FF5B8D5A556E85939");
              thread scripts\mp\hud_message::showsplash("_encstr_AA7C15C655AFE743578E6897C195737F9BB3213A532BCE");
            }

            break;
          case 2:
            if(var_1 == 0) {
              scripts\mp\utility\perk::giveperk("_encstr_A5AC149BA31D3FECB019BCA96768B35FB6781343696F");
              thread scripts\mp\hud_message::showsplash("_encstr_BE52177A022E8F02E558F37BE994530E2753F3D898B3836BA3");
            } else if(var_1 == 1) {
              scripts\mp\utility\perk::giveperk("_encstr_ACFE154BF8B3AED741511421E089BFF2C98052329813A7");
              thread scripts\mp\hud_message::showsplash("_encstr_BD09188D3A91D807AF022D09DAC3BB0177813729C2C7E8C0E70A");
            } else if(var_1 == 2) {
              scripts\mp\utility\perk::giveperk("_encstr_966512DB9F092FC45BF0CB1381BF3BE3A190584F");
              thread scripts\mp\hud_message::showsplash("_encstr_B2E71538E3774BC14ACEBBB7E5B31B36B717C098EFE880");
            }

            break;
          case 3:
            if(var_1 == 0) {
              scripts\mp\utility\perk::giveperk("_encstr_86370FAF8B1AFE183945EB42A1E2F02072");
              thread scripts\mp\hud_message::showsplash("_encstr_82D112E0D3211FF3976BBBA74CFB1AFFD6AA1010");
            } else if(var_1 == 1) {
              scripts\mp\utility\perk::giveperk("_encstr_9A871B9BA008488198DBDB8B56AADD04615713F4EB11F882C28BC8D057");
              thread scripts\mp\hud_message::showsplash("_encstr_A5431EC6588F8A782829DB2B851B7809BB5D8B01C8510268378113B1737BFAB8");
            } else if(var_1 == 2) {
              scripts\mp\utility\perk::giveperk("_encstr_8CAD12A7E8C113E2BB499BD038498BD9A988773B");
              thread scripts\mp\hud_message::showsplash("_encstr_B64C15426837D0A34F0707F73131385FBBEB36F29C223E");
            }

            break;
          case 4:
            if(var_1 == 0) {
              scripts\mp\utility\perk::giveperk("_encstr_9B6915EB59CA09FC17D103B1E7724884FCEA9643F7356A");
              thread scripts\mp\hud_message::showsplash("_encstr_822E183E626F7BF947126038FA5BA3B6CB17B1A5CA736123EB8A");
            } else if(var_1 == 1) {
              scripts\mp\utility\perk::giveperk("_encstr_95291462CB42688901F2836F40AADF6F1E5B49EDAB27");
              thread scripts\mp\hud_message::showsplash("_encstr_84BD17C8FB0907EB7F93434F64C332976A131878C29F7D811F");
            } else if(var_1 == 2) {
              scripts\mp\utility\perk::giveperk("_encstr_AC6517104BEDE9536A6D55DB8963A19151B3D808578DC35D52");
              thread scripts\mp\hud_message::showsplash("_encstr_8F0E1713E4D79B0EB236A558B11D5EF59BE8CA1619CB85B4AD");
            }

            break;
          default:
            break;
        }
      }
    }
  }
}