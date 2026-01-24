import type { Post } from '../models/Post';
import { PostCard } from './PostCard';

const MOCK_POSTS: Post[] = [
  {
    id: '1',
    title: 'Automating Your Mac with Python',
    description: 'Learn how to save hours every week by writing simple scripts to handle repetitive file management and data entry tasks.',
    date: 'Oct 24, 2023',
    categories: ['Scripting'],
    readTime: '5 min read'
  },
  {
    id: '2',
    title: 'React Hooks for Beginners',
    description: 'A comprehensive guide to understanding useState, useEffect, and custom hooks in modern React applications.',
    date: 'Oct 18, 2023',
    categories: ['Frontend'],
    readTime: '7 min read'
  },
  {
    id: '3',
    title: 'Jetpack Compose: State Management',
    description: 'Exploring the different ways to hoist state in Compose and how to architect your view models for scalability.',
    date: 'Sep 30, 2023',
    categories: ['Android', 'Jetpack Compose', 'State Management'],
    readTime: '6 min read'
  }
];

export const PostList = () => {
  return (
    <section>
      <div className="flex justify-between items-end mb-4 md:mb-8">
        <h2 className="text-2xl font-bold text-white">Recent Posts</h2>        
      </div>

      <div className="space-y-4 md:space-y-6">
        {MOCK_POSTS.map((post) => (
          <PostCard key={post.id} post={post} />
        ))}
      </div>

      <div className="mt-6 md:mt-12 flex justify-center">
        <button className="px-6 py-2 rounded-full border border-white/10 text-gray-400 text-sm hover:bg-white/5 transition-colors">
          Show all posts
        </button>
      </div>
    </section>
  );
};