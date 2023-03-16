import React from 'react';
import { Routes, Route, Navigate } from 'react-router-dom';
import Home from '../Pages/Home/index';
import Profile from '../Pages/Profile/index';

const Routers = () => {
  return (
    <Routes>
      <Route path='/' element={<Navigate to='home' />} />
      <Route path='/home' element={<Home />} />
      <Route path='/profile' element={<Profile />} />

    </Routes>
  )
}

export default Routers
