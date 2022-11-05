import { React } from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import CustomerLogin from "./components/CustomerLogin";
import CustomerMain from "./components/CustomerMain";
import Home from "./components/Home";
import NoNft from './components/NoNft';
import SellerLogin from "./components/SellerLogin";
import SellerMain from "./components/SellerMain";


function App() {
  return (

    <Router>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="seller/login" element={<SellerLogin />} />
          <Route path="seller/dashboard" element={<SellerMain />} />
          <Route path="customer/login" element={<CustomerLogin />} />
          <Route path="customer/dashboard" element={<CustomerMain />} />
          <Route path="customer/dashboard/no-nft" element={<NoNft />} />
         </Routes>
       </Router>
    // <Home/>
    // <SellerMain/>
    // <SellerLogin/>
  );
}


const server = express();
server.listen(3000);
server.post('/api', (req, res) => {
  console.log(req.body);
  res.send("Success");
});


export default App;