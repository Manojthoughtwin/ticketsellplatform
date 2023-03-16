import React, { useState } from "react";
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';
import Tabs from 'react-bootstrap/Tabs';
import Tab from 'react-bootstrap/Tab';
import 'bootstrap/dist/css/bootstrap.css';
import "./profile.css";

const ProfilePage = () => {
    const [file, setFile] = useState();
    function handleChange(e) {
        console.log(e.target.files);
        setFile(URL.createObjectURL(e.target.files[0]));
    }
    
    return (
        <>
            <h4 className='h4'>Profile Page</h4>
            <Form className='form'>
            <div class = "sign__avatar img">
                <h6>Profile Image:</h6>
                <input type="file" onChange={handleChange} />
                <img src={file} />
            </div>
            <br></br>

                <Tabs className= "Tabs" justify>
                    <Tab eventKey="first" title="Items">
                        My Items List
                    </Tab>

                    <Tab eventKey="second" title="Collections">
                        My Collections List
                    </Tab>

                    <Tab eventKey="third" title="Profile">
                        Profile Form
                    </Tab>
                </Tabs>
                <br />

                <Form.Group>
                    <Form.Control type="text"
                        placeholder="Enter First name" />
                </Form.Group>
                <br></br>

                <Form.Group>
                    <Form.Control type="text"
                        placeholder="Enter Last name" />
                </Form.Group>
                <br></br>

                <Form.Group>
                    <Form.Control type="email"
                        placeholder="Enter your your email address" />
                </Form.Group>
                <br></br>

                <Form.Group>
                    <Form.Control as="textarea" rows="3" name="address" />
                </Form.Group>
                <br></br>

                <Button variant="success" type="submit">
                    Save
                </Button>
            </Form>



        </>

    );
}

export default ProfilePage;