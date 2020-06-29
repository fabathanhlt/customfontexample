import React from 'react';
import {View, Image, StyleSheet} from 'react-native';
import {createStackNavigator} from '@react-navigation/stack';
import SplashScreen from '../scenes/splash';
import LoginScreen from '../scenes/login';
import HomeScreen from '../scenes/home';
import AppColors from '../assets/colors';
const Stack = createStackNavigator();
function MyStack() {
  return (
    <Stack.Navigator>
      <Stack.Screen
        name="SplashScreen"
        component={SplashScreen}
        options={{
          headerShown: false,
        }}
      />
      <Stack.Screen
        name="LoginScreen"
        component={LoginScreen}
        options={{
          headerShown: false,
          headerBackImage: <Image />,
          headerLeft: <View />,
        }}
      />
      <Stack.Screen
        name="HomeScreen"
        component={HomeScreen}
        options={{
          title: 'Home',
          headerShown: false,
          gestureEnabled: false,
          headerStyle: styles.mainHeader,
          headerLeft: () => <View />,
          headerBackImage: <Image />,
        }}
      />
    </Stack.Navigator>
  );
}

const styles = StyleSheet.create({
  mainHeader: {
    backgroundColor: AppColors.barTintColor,
  },
});

export default MyStack;
