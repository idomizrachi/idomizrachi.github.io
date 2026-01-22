import type { Post } from '../models/Post';
import { CategoryBadge } from './CategoryBadge';

interface PostCardProps {
  post: Post;
}

export const PostCard = ({ post }: PostCardProps) => {
  return (
    <article className="group p-8 bg-[#151c2f] rounded-2xl border border-white/5 hover:border-white/10 transition-all cursor-pointer text-left">
      <h3 className="text-2xl font-bold text-white mb-3 group-hover:text-sky-400 transition-colors">
        {post.title}
      </h3>
      <div className="flex justify-between items-start mb-4">
        <div className="flex gap-2 flex-wrap">
          {post.categories.map((category) => (
            <CategoryBadge key={category} category={category} />
          ))}
        </div>     
        <div className="flex items-center gap-3 text-sm text-gray-400">                    
          <span>{post.date}</span>
        </div>
      </div>      
      <p className="text-gray-400 leading-relaxed mb-6 line-clamp-2">
        {post.description}
      </p>
      <div className="flex justify-between items-center">
        <button className="flex items-center gap-2 text-white font-medium text-sm rounded-full px-4 py-2 bg-sky-500 hover:bg-sky-400 text-[#0b1121] font-bold py-2 rounded-lg transition-colors shadow-lg shadow-sky-500/20">
          Read Article <span className="group-hover:translate-x-1 transition-transform">→</span>
        </button>
        <span className="text-xs text-gray-500">{post.readTime}</span>
      </div>
    </article>
  );
};