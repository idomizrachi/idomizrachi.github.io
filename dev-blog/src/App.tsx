import { useState } from 'react'

import './App.css'
import { Sidebar } from './components/Sidebar'
import { PostList } from './components/PostList'

function App() {
  const [count, setCount] = useState(0)

  return (
    <>
      <div className="min-h-screen bg-[#0b1121] text-white font-sans">
      {/* <Navbar /> */}
      
      {/* Main Container */}
      <main className="max-w-7xl mx-auto px-6 py-10">
        <div className="grid grid-cols-1 lg:grid-cols-12 gap-12">
          
          {/* Left Side: Main Content (8 columns) */}
          <div className="lg:col-span-8 space-y-12">
            {/* <Hero /> */}
            <PostList />
          </div>

          {/* Right Side: Sidebar (4 columns) */}
          <aside className="lg:col-span-4 space-y-8">
            <Sidebar />
          </aside>
          
        </div>
      </main>
    </div>
    </>
  )
}

export default App
