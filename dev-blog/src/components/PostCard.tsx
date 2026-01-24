import type { Post } from '../models/Post';
import { CategoryBadge } from './CategoryBadge';

interface PostCardProps {
  post: Post;
}

export const PostCard = ({ post }: PostCardProps) => {
  return (
    <article className="group p-4 md:p-8 bg-[#151c2f] rounded-2xl border border-white/5 hover:border-white/10 transition-all cursor-pointer text-left">
      <h3 className="text-2xl font-bold text-white mb-2 md:mb-3 group-hover:text-sky-400 transition-colors">
        <a href="#">
        {post.title}
        </a>
      </h3>
      <div className="flex justify-between items-start mb-3 md:mb-4">
        <div className="flex gap-2 flex-wrap">
          {post.categories.map((category) => (
            <CategoryBadge key={category} category={category} />
          ))}
        </div>     
        <div className="flex items-center gap-3 text-sm text-gray-400">                    
          <span>{post.date}</span>
        </div>
      </div>      
      <p className="text-gray-400 leading-relaxed mb-4 md:mb-6 line-clamp-2">
        {post.description}
      </p>      
    </article>
  );
};