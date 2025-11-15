/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_qrcode.csc
**************************************/

init() {
}

setup_qr_code(mapname, slot, userrequest) {
  if(isDefined(mapname)) {
    switch (mapname) {
      case "blackout":
        createqrcode("http://treyarch.com", 0);
        __asm_jmp(loc_1E4)
      case "haiti":
        __asm_jmp(loc_1E4)
      case "karma":
        createqrcode("http://treyarch.com", 0);
        __asm_jmp(loc_1E4)
      case "karma_2":
        __asm_jmp(loc_1E4)
      case "la_1":
      case "la_1b":
      case "la_2":
      case "monsoon":
      case "pakistan":
      case "pakistan_2":
      case "pakistan_3":
      case "yemen":
        __asm_jmp(loc_1E4)
      case "frontend":
        switch (slot) {
          case 0:
          case 1:
          case 2:
            break;
          case 3:
            createqrcode(level.music_tracks_qr[userrequest], 3);
            break;
        }
    }
  }
}

setupmusiccodes(num) {
  level.music_tracks_qr = [];

  for(i = 0; i < num; i++)
    level.music_tracks_qr[i] = "http://itunes/sales";
}