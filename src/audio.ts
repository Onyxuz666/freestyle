import { requireOptionalNativeModule } from 'expo-modules-core';

export type AudioState = {playing:boolean; recording:number; phase:number; filled:boolean[]; muted:boolean[]};
export const initialState: AudioState = {playing:false,recording:-1,phase:0,filled:[false,false,false,false],muted:[false,false,false,false]};
type AudioAPI = {
  prepare():Promise<void>;
  play(bpm:number):void;
  stop():void;
  beginRecording(track:number):void;
  endRecording():void;
  mute(track:number):void;
  clear(track:number):void;
  getState():AudioState;
};
export const audio = requireOptionalNativeModule<AudioAPI>('FreestyleAudio');
