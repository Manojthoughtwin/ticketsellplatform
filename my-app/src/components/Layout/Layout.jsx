import React from 'react';
import Routers from '../../Routes/Routers';
import Header from '../Header/Header';
import Footer from '../Footer/Footer';
const Layout = () => {
  return (
    <>
        <Header/>
        <div>
            <Routers/>
        </div>
        <Footer/>
    </>
  )
}

export default Layout
