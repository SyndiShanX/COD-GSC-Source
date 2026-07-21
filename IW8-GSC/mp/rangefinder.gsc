/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\rangefinder.gsc
***********************************************/

runmprangefinder() {
  precachemodel("_encstr_AD6A115B77AF9BC60BC62BEBDCF6D846A5ACC9");
  precachemodel("_encstr_A37410D677FAA3566E3ABE9BDBC623A5CA4E");
  precachemodel("_encstr_95E410ADDDBE91969B1DEBB9F63623B4AC4E");
  wait 5.0;

  for(;;) {
    if(getdvarint("_encstr_B6AA10DC6C39BE9316379D95914B9B192BE4", 0) == 1) {
      var_0 = createcamnode();
      thread addmodeltoplayer(var_0);

      while(getdvarint("_encstr_B6AA10DC6C39BE9316379D95914B9B192BE4", 0) == 1)
        wait 0.01;

      var_0 delete();
      level notify("_encstr_A69410E6815B09237F6288205A8A9F81832C");
    }

    wait 0.01;
  }
}

createcamnode() {
  var_0 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", level.players[0].origin);
  var_0 thread monitorplacement();
  var_0 thread managelink();
  return var_0;
}

monitorplacement() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A69410E6815B09237F6288205A8A9F81832C");
  self.placementmode = "_encstr_8BB007E03658CBCAE4";

  for(;;) {
    if(getdvarint("_encstr_B6AA10DC6C39BE9316379D95914B9B192BE4", 0) == 1) {
      if(level.players[0] useButtonPressed()) {
        self.placementmode = scripts\engine\utility::ter_op(self.placementmode == "_encstr_8BB007E03658CBCAE4", "_encstr_88FA0B7271CF407FE86D0FEBE3", "_encstr_8BB007E03658CBCAE4");
        level.players[0] notify("_encstr_A75B1626F01F506FFFEA493802961F49476538257DFFD9A3");

        while(level.players[0] useButtonPressed())
          waitframe();
      }
    }

    wait 0.01;
  }
}

managelink() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_A69410E6815B09237F6288205A8A9F81832C");
  thread softlink();

  for(;;) {
    level.players[0] waittill("_encstr_A75B1626F01F506FFFEA493802961F49476538257DFFD9A3");

    if(self.placementmode == "_encstr_8BB007E03658CBCAE4") {
      iprintlnbold("_encstr_A1C20C01611344BB273E2931100F");
      thread softlink();
    } else
      iprintlnbold("_encstr_997210BFFB7B9F23079DE9EBDFBAD5A9ADE0");

    wait 0.01;
  }
}

softlink() {
  level.players[0] endon("_encstr_A75B1626F01F506FFFEA493802961F49476538257DFFD9A3");
  level endon("_encstr_A69410E6815B09237F6288205A8A9F81832C");

  for(;;) {
    self.angles = (0, 90 + level.players[0].angles[1], 0);
    var_0 = anglesToForward(level.players[0].angles) * 40;
    self.origin = level.players[0].origin - var_0;
    wait 0.01;
  }
}

addmodeltoplayer(var_0) {
  var_1 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0.origin);
  var_1.angles = var_0.angles;
  var_1 setModel("_encstr_95E410ADDDBE91969B1DEBB9F63623B4AC4E");
  var_1 linkTo(var_0);
  var_1 thread watchrangefinderend();
}

watchrangefinderend() {
  level waittill("_encstr_A69410E6815B09237F6288205A8A9F81832C");
  self delete();
}