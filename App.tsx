import React, {useEffect, useRef, useState} from 'react';
import {AppState, Pressable, SafeAreaView, ScrollView, StyleSheet, Text, View} from 'react-native';
import {StatusBar} from 'expo-status-bar';
import {audio, AudioState, initialState} from './src/audio';

const names = ['BEAT', 'BASS', 'MELODY', 'VOICE'];
const colors = ['#c7f878','#ffb86b','#a9a1ff','#ff91ad'];
export default function App() {
  const [state,setState] = useState<AudioState>(initialState);
  const [bpm,setBpm] = useState(100);
  const [ready,setReady] = useState(false);
  const [error,setError] = useState('');
  const held = useRef(false);
  const act = (fn:()=>void) => {try {fn(); if(audio) setState(audio.getState());} catch(e) {setError(String(e));}};
  useEffect(()=>{
    if(!audio) return;
    const timer=setInterval(()=>act(()=>{}),80);
    const sub=AppState.addEventListener('change',s=>{if(s!=='active')act(()=>audio?.stop());});
    return ()=>{clearInterval(timer);sub.remove();audio?.stop();};
  },[]);
  const prepare = async()=>{try {await audio?.prepare();setReady(true);setError('');}catch(e){setError(String(e));}};
  const begin=(i:number)=>{
    held.current=true;
    act(()=>{if(audio && ready){if(!state.playing)audio.play(bpm);audio.beginRecording(i);}});
  };
  return <SafeAreaView style={s.root}><StatusBar style="light"/><ScrollView contentContainerStyle={s.page}>
    <Text style={s.eyebrow}>YOUR VOICE. YOUR INSTRUMENT.</Text>
    <Text style={s.title}>freestyle<Text style={{color:'#c7f878'}}>●</Text></Text>
    <Text style={s.sub}>Make a sound. Make it a song.</Text>
    <View style={s.transport}>
      <View style={s.row}><Text style={s.label}>SESSION 001</Text><Text style={s.label}>2 BARS · 4/4</Text></View>
      <View style={s.beats}>{Array.from({length:8},(_,i)=><View key={i} style={[s.beat,{backgroundColor:state.playing && Math.floor(state.phase*8)===i?'#c7f878':'#30372e'}]}/>)}</View>
      <View style={s.row}>
        <Pressable accessibilityLabel="Decrease tempo" disabled={state.playing||state.filled.some(Boolean)} onPress={()=>setBpm(Math.max(60,bpm-5))}><Text style={s.adjust}>−</Text></Pressable>
        <Text style={s.tempo}>{bpm} <Text style={s.label}>BPM</Text></Text>
        <Pressable accessibilityLabel="Increase tempo" disabled={state.playing||state.filled.some(Boolean)} onPress={()=>setBpm(Math.min(180,bpm+5))}><Text style={s.adjust}>+</Text></Pressable>
        <Pressable style={s.play} disabled={!ready||!audio} onPress={()=>act(()=>state.playing?audio?.stop():audio?.play(bpm))}><Text style={s.dark}>{state.playing?'■ STOP':'▶ PLAY'}</Text></Pressable>
      </View>
    </View>
    {!audio?<Text style={s.notice}>Interface preview · Audio needs the custom iPhone development build.</Text>:!ready?<Pressable style={s.enable} onPress={prepare}><Text style={s.dark}>ENABLE MICROPHONE</Text></Pressable>:<Text style={s.notice}>Use headphones. Hold a pad to record; release to loop. Each take fills up to two bars.</Text>}
    {error!=='' && <Text accessibilityRole="alert" style={s.error}>{error}</Text>}
    {names.map((name,i)=><View key={name} style={[s.track,state.recording===i && {borderColor:'#ff615f'}]}>
      <View style={s.row}><Text style={[s.label,{color:colors[i]}]}>0{i+1} / {name}</Text><Text style={s.label}>{state.recording===i?'RECORDING':state.filled[i]?'LOOP READY':'EMPTY'}</Text></View>
      <Pressable accessibilityLabel={`Hold to record ${name.toLowerCase()}`} disabled={!audio||!ready||state.filled[i]} onPressIn={()=>begin(i)} onPressOut={()=>{if(held.current){held.current=false;act(()=>audio?.endRecording());}}} style={[s.pad,{borderColor:colors[i]}]}>
        <Text style={[s.padIcon,{color:colors[i]}]}>{state.recording===i?'●':state.filled[i]?'≋':'+'}</Text>
        <Text style={s.padText}>{state.recording===i?'RELEASE TO LOOP':state.filled[i]?'YOUR SOUND IS IN':'HOLD TO RECORD'}</Text>
      </Pressable>
      <View style={s.row}><Pressable disabled={!state.filled[i]} onPress={()=>act(()=>audio?.mute(i))}><Text style={[s.action,state.muted[i]&&{color:colors[i]}]}>{state.muted[i]?'UNMUTE':'MUTE'}</Text></Pressable><Pressable disabled={!state.filled[i]||state.recording>=0} onPress={()=>act(()=>audio?.clear(i))}><Text style={s.action}>CLEAR</Text></Pressable></View>
    </View>)}
    <Text style={s.footer}>FIRST LOOP PROTOTYPE · Sessions are not saved yet.</Text>
  </ScrollView></SafeAreaView>;
}
const s=StyleSheet.create({
  root:{flex:1,backgroundColor:'#10130f'},page:{padding:24,paddingTop:35,paddingBottom:48,maxWidth:600,width:'100%',alignSelf:'center'},
  eyebrow:{color:'#a8b09e',fontSize:10,letterSpacing:2},title:{color:'#f5f7ef',fontSize:54,fontWeight:'900',letterSpacing:-3},sub:{color:'#a8b09e',fontSize:15,marginBottom:28},
  transport:{backgroundColor:'#1d241b',borderRadius:22,padding:20,marginBottom:14},row:{flexDirection:'row',alignItems:'center',justifyContent:'space-between'},label:{color:'#a8b09e',fontSize:10,fontWeight:'700',letterSpacing:1},
  beats:{flexDirection:'row',gap:7,marginVertical:22},beat:{height:28,flex:1,borderRadius:5},tempo:{color:'#fff',fontSize:25,fontWeight:'700'},adjust:{color:'#c7f878',fontSize:30,padding:8},play:{backgroundColor:'#c7f878',padding:17,borderRadius:14},dark:{color:'#141a11',fontWeight:'800',fontSize:12},
  notice:{color:'#a8b09e',fontSize:12,lineHeight:19,marginBottom:18},enable:{backgroundColor:'#c7f878',padding:18,borderRadius:12,alignItems:'center',marginBottom:18},error:{color:'#ff9696',marginBottom:16},
  track:{borderWidth:1,borderColor:'#30372e',borderRadius:20,padding:18,marginBottom:13},pad:{marginVertical:14,borderWidth:1,borderRadius:14,alignItems:'center',paddingVertical:12,backgroundColor:'#191d17'},padIcon:{fontSize:32,fontWeight:'600'},padText:{color:'#d9dfd2',fontSize:10,letterSpacing:1.5,marginBottom:4},action:{color:'#a8b09e',fontSize:10,fontWeight:'700',padding:8},footer:{color:'#71806a',fontSize:10,textAlign:'center',marginTop:15}
});
