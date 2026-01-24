import './App.css'
import { Sidebar } from './components/Sidebar'
import { PostList } from './components/PostList'
import { Footer } from './components/Footer'
import { NavigationBar } from './components/NavigationBar'

function App() {
  return (
    <>
      <div className="bg-[#0b1121] flex flex-col">      
      <NavigationBar />
      {/* Main Container */}
      <main className="max-w-7xl mx-auto px-4 py-6 md:px-6 md:py-10 flex-1">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-6 lg:gap-12">
          
          {/* Left Side: Main Content */}
          <div className="lg:col-span-9 space-y-6 lg:space-y-12">
            {/* <Hero /> */}
            <PostList />
          </div>          

          {/* Right Side: Sidebar */}
          <aside className="lg:col-span-3 space-y-8">
            <Sidebar />
          </aside>          
        </div>
      </main>      
      <Footer />
    </div>    
    </>    
  )
}

export default App
