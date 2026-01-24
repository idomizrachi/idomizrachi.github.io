export const NavigationBar = () => {
    return (
        <header className="sticky top-0 z-50 border-b border-border-dark bg-background-dark/80 backdrop-blur-md px-6 py-3">
            <div className="max-w-7xl mx-auto flex flex-col md:flex-row items-center justify-between gap-4">
                <div className="flex items-center gap-8 w-full md:w-auto justify-between md:justify-start">
                    <a className="flex items-center gap-3 text-text-main hover:opacity-80 transition-opacity" href="#">                        
                        <h2 className="text-l font-bold tracking-tight">DevLog</h2>
                    </a>
                    <nav className="hidden md:flex items-center gap-6">
                        <a className="text-sm font-medium hover:text-primary transition-colors text-primary" href="#">Home</a>
                        <a className="text-text-muted text-sm font-medium hover:text-primary transition-colors" href="#">Topics</a>
                        <a className="text-text-muted text-sm font-medium hover:text-primary transition-colors" href="#">About Me</a>
                    </nav>
                </div>
                
            </div>
        </header>
    );
};