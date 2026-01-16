/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\mp_apartments_lighting.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\exploder_shared;
#namespace namespace_e7a4a9df;

function function_c667ac79() {
  state = 0;
  image = 0;
  laststate = 0;
  while (true) {
    if(state == 0) {
      exploder::kill_exploder("light_em_tv_01_dim");
      exploder::exploder("light_em_tv_01_dim_fx");
    } else if(laststate == 0) {
      exploder::exploder("light_em_tv_01_dim");
      exploder::kill_exploder("light_em_tv_01_dim_fx");
    }
    if(state == 1) {
      exploder::exploder("light_em_tv_01_bright");
    } else if(laststate == 1) {
      exploder::kill_exploder("light_em_tv_01_bright");
    }
    if(state == 2) {
      exploder::exploder("light_em_tv_02_dim");
    } else if(laststate == 2) {
      exploder::kill_exploder("light_em_tv_02_dim");
    }
    if(state == 3) {
      exploder::exploder("light_em_tv_02_bright");
    } else if(laststate == 3) {
      exploder::kill_exploder("light_em_tv_02_bright");
    }
    wait(0.25);
    laststate = state;
    if(state % 2) {
      state = state - 1;
    } else {
      state = state + 1;
    }
    image = image + 1;
    if(image == 8) {
      image = 0;
      state = (state + 2) % 4;
    }
  }
}

function main() {
  thread function_c667ac79();
}