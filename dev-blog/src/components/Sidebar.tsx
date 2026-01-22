import { CategoryBadge } from './CategoryBadge';

export const Sidebar = () => {
    return (
      <div className="flex flex-col gap-8">
        {/* Profile Card */}
        <section className="bg-[#151c2f] p-6 rounded-2xl border border-white/5">
          <div className="flex items-center gap-4 mb-4">
            <img src="/profile.png" className="w-12 h-12 rounded-full border-2 border-sky-400" alt="Alex Dev" />
            <div>
              <h3 className="font-bold text-lg">Ido Mizrachi</h3>
              <p className="text-sky-400 text-xs uppercase tracking-wider">Full Stack Engineer</p>
            </div>
          </div>
          <p className="text-gray-400 text-sm leading-relaxed">
            I write about building scalable apps and the journey of continuous learning.
          </p>
        </section>
  
        {/* Topics Card */}
        <section className="p-6 rounded-2xl text-left">
          <h4 className="text-sm font-semibold uppercase text-gray-500 mb-4 tracking-widest">Popular Topics</h4>
          <div className="flex flex-wrap gap-2">
            {['iOS Dev', 'SwiftUI', 'Python', 'React', 'Backend'].map(tag => (
              <CategoryBadge key={tag} category={tag} />
            ))}
          </div>
        </section>
  
        
      </div>
    );
  };