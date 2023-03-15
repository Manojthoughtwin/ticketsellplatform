import Index from "./components/Profile/index";
import "bootstrap/dist/css/bootstrap.min.css";
// import logo from "./logo.svg";
import "./App.css";
import Home from "./components/Home/index";
import { Container, Row, Col, Button } from "react-bootstrap";
import "./index.css";

function App() {
  return (
    <>
      <Container fluid>
        <Row>
          <Col>
            <Home />
            <Button>Name</Button>
            <Index />
          </Col>
        </Row>
      </Container>
    </>
  );
}

export default App;
