/**********************************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_royal_hotel\mp_royal_hotel_lighting.gsc
**********************************************************************/

main() {
  level._id_45CE = "mp_royal_hotel";
  level._id_59D6 = "mp_royal_hotel_winner";
  level._id_10E5E = "mp_royal_hotel_winner";
  level._id_84D1 = "mp_royal_hotel_intro";
  level.infilvisionset = "mp_royal_hotel_winner";
  thread flares();
}

flares() {
  wait 1;
}