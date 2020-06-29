import React from 'react';
import {View, StyleSheet, Text} from 'react-native';

const HomeScreen = ({props, route}) => {
  const {userName} = route.params;
  return (
    <View style={styles.container}>
      <Text style={styles.text}>Hello {userName}</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'blue',
    justifyContent: 'center',
    alignContent: 'center',
  },
  text: {
    textAlign: 'center',
  },
});

export default HomeScreen;
