import React, { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import api from '../../config/axios';
import HeaderTemplate from '../../components/header-page';
import './index.css';



const BlogList = () => {
    const [blogs, setBlogs] = useState([]);
    const [featuredBlog, setFeaturedBlog] = useState(null);

    useEffect(() => {
        const fetchBlogs = async () => {
            const response = await api.get('Blog/GetAllBlog');
            if (response.data.length > 0) {
                setFeaturedBlog(response.data[0]);
                setBlogs(response.data.slice(1));
            }
        };
        fetchBlogs();
    }, []);

    return (
        <>
            <HeaderTemplate />
            <div className="blog-container">
                <h1 className="blog-title">Blogs của chúng tôi</h1>
                
                {featuredBlog && (
                    <div className="featured-blog">
                        <img src={featuredBlog.image} alt={featuredBlog.heading} className="featured-blog-image" />
                        <div className="featured-blog-content">
                            <h2 className="featured-blog-title">{featuredBlog.heading}</h2>
                            <p className="featured-blog-excerpt">{featuredBlog.excerpt}</p>
                            <Link to={`/blog-detail/${featuredBlog.blogId}`} className="read-more-btn">Xem chi tiết</Link>
                        </div>
                    </div>
                )}

                <div className="blog-grid">
                    {blogs.map((post) => (
                        <article key={post.id} className="blog-post">
                            <img src={post.image} alt={post.heading} className="blog-post-image" />
                            <div className="blog-post-content">
                                <h3 className="blog-post-title">{post.heading}</h3>
                                <p className="blog-post-excerpt">{post.excerpt}</p>
                                <Link to={`/blog-detail/${post.blogId}`} className="read-more-link">Xem chi tiết</Link>
                            </div>
                        </article>
                    ))}
                </div>
            </div>
        </>
    );
};

export default BlogList;
