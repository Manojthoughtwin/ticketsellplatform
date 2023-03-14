import React from 'react';
import 'bootstrap/dist/css/bootstrap.css';
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';
import ListGroup from 'react-bootstrap/ListGroup';
import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import Tabs from 'react-bootstrap/Tabs';
import Tab from 'react-bootstrap/Tab';


const Index = () => {
    return (
        <>
            <h4 className='h4'>Profile Page</h4>
            <Form className='form'>

                <Tabs className='Tabs'>
                    <Tab eventKey="first" title="My Items">
                       My Items List
                    </Tab>
                    <Tab eventKey="second" title="My Collections">
                       My Collections List
                    </Tab>
                    <Tab eventKey="third" title="Profile">
                        Profile Form
                    </Tab>
                </Tabs>

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

export default Index;