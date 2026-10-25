import React, { useEffect, useState, useCallback } from 'react';
import { View, Text, Button, StyleSheet, ActivityIndicator, Linking, SafeAreaView } from 'react-native';
import * as Location from 'expo-location';

export default function App() {
  const [coords, setCoords] = useState(null);
  const [status, setStatus] = useState('loading'); // loading | ready | denied | gpsOff | error
  const [errorMsg, setErrorMsg] = useState('');

  const getLocation = useCallback(async () => {
    setStatus('loading');
    try {
      // 1. Ask runtime permission
      const { status: perm } = await Location.requestForegroundPermissionsAsync();
      if (perm !== 'granted') {
        setStatus('denied');
        return;
      }
      // 2. Is GPS / location service on?
      if (!(await Location.hasServicesEnabledAsync())) {
        setStatus('gpsOff');
        return;
      }
      // 3. Read GPS position
      const pos = await Location.getCurrentPositionAsync({
        accuracy: Location.Accuracy.High,
      });
      setCoords(pos.coords);
      setStatus('ready');
    } catch (e) {
      setErrorMsg(String(e.message || e));
      setStatus('error');
    }
  }, []);

  useEffect(() => { getLocation(); }, [getLocation]);

  return (
    <SafeAreaView style={s.container}>
      <Text style={s.title}>GPS Location</Text>

      {status === 'loading' && (
        <>
          <ActivityIndicator size="large" color="#009688" />
          <Text style={s.msg}>Getting GPS location...</Text>
        </>
      )}

      {status === 'ready' && coords && (
        <View style={s.card}>
          <Text style={s.label}>Latitude</Text>
          <Text style={s.value}>{coords.latitude.toFixed(6)}</Text>
          <Text style={s.label}>Longitude</Text>
          <Text style={s.value}>{coords.longitude.toFixed(6)}</Text>
          <Text style={s.small}>Accuracy: ±{coords.accuracy?.toFixed(1)} m</Text>
        </View>
      )}

      {status === 'denied' && (
        <>
          <Text style={s.msg}>Location permission denied. The app needs it to show your coordinates.</Text>
          <Button title="Try Again" onPress={getLocation} />
          <View style={{ height: 8 }} />
          <Button title="Open App Settings" onPress={() => Linking.openSettings()} />
        </>
      )}

      {status === 'gpsOff' && (
        <>
          <Text style={s.msg}>Location (GPS) is turned off. Please turn it on.</Text>
          <Button title="Try Again" onPress={getLocation} />
        </>
      )}

      {status === 'error' && (
        <>
          <Text style={s.msg}>Error: {errorMsg}</Text>
          <Button title="Retry" onPress={getLocation} />
        </>
      )}

      {status !== 'loading' && status !== 'denied' && (
        <View style={{ marginTop: 24 }}>
          <Button title="Refresh Location" onPress={getLocation} color="#009688" />
        </View>
      )}
    </SafeAreaView>
  );
}

const s = StyleSheet.create({
  container: { flex: 1, alignItems: 'center', justifyContent: 'center', padding: 24, backgroundColor: '#fff' },
  title: { fontSize: 28, fontWeight: 'bold', marginBottom: 24 },
  card: { width: '100%', padding: 20, borderRadius: 12, backgroundColor: '#e0f2f1', alignItems: 'center' },
  label: { fontSize: 16, color: '#555', marginTop: 8 },
  value: { fontSize: 32, fontWeight: 'bold', color: '#00695c' },
  small: { marginTop: 16, color: '#555' },
  msg: { fontSize: 16, textAlign: 'center', marginVertical: 16 },
});
